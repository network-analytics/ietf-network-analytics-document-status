-- Wireshark UDP-Notif dissector

-- https://github.com/network-analytics/draft-ietf-netconf-udp-notif
-- https://datatracker.ietf.org/doc/draft-ietf-netconf-udp-notif/11

-- SPDX-License-Identifier: GPL-2.0-or-later

local plugin_info = {
  version = "0.0.1s",
  description = "UDP-Notif dissector",
  author = "Uwe Storbeck",
  repository = "https://github.com/network-analytics/udp-notif-dissector"
}
set_plugin_info(plugin_info)

un_prot = Proto("udpnotif", "UDP-Notif")

local yesno_type = {
  [0] = "no",
  [1] = "yes"
}

local mts_type = {
  [0] = "standard media types",
  [1] = "private encoding"
}

local media_type = {
  [0] = "Reserved",
  [1] = "application/yang-data+json",
  [2] = "application/yang-data+xml",
  [3] = "application/yang-data+cbor"
}

local option_type = {
  [1] = "Segmentation",
  [2] = "Private Encoding"
}

local f_ver = ProtoField.uint8("udpnotif.hdr_vers", "Header Version", base.DEC, none, 0xe0)
local f_mts = ProtoField.uint8("udpnotif.media_type_space", "Media Type Space", base.DEC, mts_type, 0x10)
local f_std_mt = ProtoField.uint8("udpnotif.media_type", "Media Type", base.DEC, media_type, 0x0f)
local f_priv_enc = ProtoField.uint8("udpnotif.priv_enc", "Private Encoding", base.DEC, none, 0x0f)
local f_hdr_len = ProtoField.uint8("udpnotif.hdr_len", "Header Length", base.DEC)
local f_msg_len = ProtoField.uint16("udpnotif.msg_len", "Message Length", base.DEC)
local f_pub_id = ProtoField.uint32("udpnotif.publisher", "Publisher ID", base.DEC)
local f_msg_id = ProtoField.uint32("udpnotif.msg_id", "Message ID", base.DEC)
local f_opt_type = ProtoField.uint8("udpnotif.opt_type", "Option Type", base.DEC, option_type)
local f_opt_len = ProtoField.uint8("udpnotif.opt_len", "Option Length", base.DEC)
local f_opt_data = ProtoField.none("udpnotif.opt_data", "Option Data")
local f_seg_num = ProtoField.uint16("udpnotif.seg_num", "Segment Number", base.DEC, none, 0xfffe)
local f_last_seg = ProtoField.uint16("udpnotif.last_seg", "Last Segment", base.DEC, yesno_type, 0x0001)
local f_enc_desc = ProtoField.string("udpnotif.enc_desc", "Encoding Description", base.TEXT)
local f_payload = ProtoField.none("udpnotif.payload", "UDP-Notif Payload")

un_prot.fields = { f_ver, f_mts, f_std_mt, f_priv_enc, f_hdr_len, f_msg_len,
                   f_pub_id, f_msg_id, f_opt_type, f_opt_len, f_opt_data,
                   f_seg_num, f_last_seg, f_enc_desc, f_payload }

function un_prot.init()
  segments = {}  -- global array table to hold the segments
end

function un_prot.dissector(buf, pkt, tree)

  -- make sure we have at least 12 bytes in the buffer
  if buf:len() < 12 then return end

  local mt_std = bit.band(buf(0,1):uint(),0x10) == 0
  local mt = bit.band(buf(0,1):uint(), 0x0f)
  local hdr_len = buf(1,1):uint()
  local msg_len = buf(2,2):uint()
  local pub_id = buf(4,4):uint()
  local msg_id = buf(8,4):uint()
  local segmented = false
  local last_seg = false
  local message = ByteArray.new()

  pkt.cols.protocol = un_prot.name

  local subtree = tree:add(un_prot, buf(0,hdr_len),
                           "UDP-Notif Protocol, Publisher: " .. pub_id .. ", Msg ID: " .. msg_id)
  subtree:add(f_ver, buf(0,1))
  subtree:add(f_mts, buf(0,1))
  if mt_std then
    subtree:add(f_std_mt, buf(0,1))
  else
    subtree:add(f_priv_enc, buf(0,1))
  end
  subtree:add(f_hdr_len, buf(1,1))
  subtree:add(f_msg_len, buf(2,2))
  subtree:add(f_pub_id, buf(4,4))
  subtree:add(f_msg_id, buf(8,4))
  if hdr_len < 12 then
    print("header length too small (" .. hdr_len .. "), must be at least 12")
    hdr_len = 12
  end

  -- handle options
  local i = 12
  while i < hdr_len - 1 do
    local opt_type = buf(i,1):uint()
    local opt_len = buf(i+1,1):uint()
    if opt_len < 2 then
      print("option length too small (" .. opt_len .. "), must be at least 2")
      opt_len = 2
    end
    if opt_len > hdr_len - i then
      print("option length too large for header size (" .. opt_len .. ")")
      opt_len = hdr_len - i
    end

    if opt_type == 1 then -- segmentation
      segmented = true
      last_seg = bit.band(buf(i+3,1):uint(), 0x01) ~= 0
      local seg_num = bit.rshift(buf(i+2,2):uint(), 1)
      local seg_str = ""
      if last_seg then seg_str = " (last)" end

      -- save and reassemble segments
      if segments[pub_id] == nil then segments[pub_id] = {} end
      if segments[pub_id][msg_id] == nil then segments[pub_id][msg_id] = {} end
      segments[pub_id][msg_id][seg_num] = buf(hdr_len):bytes()
      if last_seg then
        local j = 0
        while segments[pub_id][msg_id][j] do
          message = message .. segments[pub_id][msg_id][j]
          j = j + 1
        end
      end

      local opttree = subtree:add(un_prot, buf(i,opt_len),
                                  "Option: Segmentation, Segment Number: "
                                  .. seg_num .. seg_str)
      opttree:add(f_opt_type, buf(i,1))
      opttree:add(f_opt_len, buf(i+1,1))
      opttree:add(f_seg_num, buf(i+2,2))
      opttree:add(f_last_seg, buf(i+2,2))

    elseif opt_type == 2 then -- private encoding
      local opttree = subtree:add(un_prot, buf(i,opt_len),
                                  "Option: Private Encoding")
      opttree:add(f_opt_type, buf(i,1))
      opttree:add(f_opt_len, buf(i+1,1))
      opttree:add(f_enc_desc, buf(i+2,opt_len-2))

    else
      local opttree = subtree:add(un_prot, buf(i,opt_len))
      opttree:add(f_opt_type, buf(i,1))
      opttree:add(f_opt_len, buf(i+1,1))
      opttree:add(f_opt_data, buf(i+2,opt_len-2))
    end
    i = i + opt_len
  end

  if mt_std then
    local payload = "data"
    if mt == 1 then payload = "json"
    elseif mt == 2 then payload = "xml"
    elseif mt == 3 then payload = "cbor"
    end
    local data_dis = Dissector.get(payload)
    if segmented then
      subtree:add(f_payload, buf(i,msg_len-i)):append_text(" (" .. msg_len-i .. " bytes)")
      if last_seg then data_dis:call(message:tvb(), pkt, tree) end
    else
      data_dis:call(buf(hdr_len):tvb(), pkt, tree)
    end
  else
    subtree:add(f_payload, buf(i,msg_len-i)):append_text(" (" .. msg_len-i .. " bytes)")
  end
end

-- register protocol
DissectorTable.get("udp.port"):add(0, un_prot)
