## Installation

### From RPM (Recommended for RHEL/Rocky/Alma Linux)

Pre-built RPM packages are available on the [GitHub Releases](https://github.com/NetGauze/NetGauze/releases) page.

1. Download the latest RPM for your architecture (e.g., `netgauze-collector-X.Y.Z-1.el8.x86_64.rpm`).
2. Install using `dnf` or `rpm`:
   ```bash
   sudo dnf install ./netgauze-collector-*.rpm
   ```
   The RPM installs the binary to `/usr/bin/netgauze-collector` and sets the necessary capabilities (`cap_net_raw+ep`).

### From Source

To build from source, you need a Rust toolchain installed. We recommend using [rustup](https://rustup.rs/).

1. Clone the repository:
   ```bash
   git clone https://github.com/NetGauze/NetGauze.git
   cd NetGauze
   ```
2. Run using cargo:
   ```bash
   cargo run -p netgauze-collector --release -- crates/collector/config.yaml
   ```
   *Note: You might need to install development libraries such as `libcurl-devel` (or `libcurl4-openssl-dev` on Debian/Ubuntu) depending on your OS.*

## Configuration

Up to date configuration examples can be found in the `crates/collector` directory of the repository, or online at [https://github.com/NetGauze/NetGauze/tree/main/crates/collector](https://github.com/NetGauze/NetGauze/tree/main/crates/collector).

## Running the Collector

Run the collector with a specific config file:
```bash
netgauze-collector /path/to/config.yaml
# Or if running from source:
cargo run -p netgauze-collector -- /path/to/config.yaml
```