# RavadaVDI hardening server with Wazuh

RavadaVDI Security Configuration Assessment

[![Wazuh](https://img.shields.io/badge/Wazuh-4.x-blue)](https://wazuh.com)
[![License](https://img.shields.io/badge/License-GPL--2.0-green)](LICENSE)

Community integration of the **RavadaVDI hardening server** for [Wazuh](https://wazuh.com).

---

## Project Status

> [!WARNING]
> This project is under active development and some controls are still being validated.\
> Your feedback, testing results, and contributions are strongly encouraged to help improve accuracy, completeness, and reliability.

---

## What is RavadaVDI?

Ravada is an open-source project that allows users to connect to a Virtual Desktop. It is a VDI broker. More information in this [link](https://ravada.upc.edu). 

---

## What this SCA provides

| Component | Description |
|-----------|-------------|
| **SCA Policies** | YAML policies for Ravada server agents that audit system configuration |
| **Detection Rules** | Custom Wazuh rules tagged with RavadaVDI control references |

Use range 100000–299999 for custom checks.

### Checks

* Ensure secure permissions on configuration files
* Verify secure cluster configuration (Required for v2.4+)
* Ensure Ravada package is installed
* Verify frontend daemon service is running
* Verify backend daemon service is running
* Libvirt: Ensure TLS/SSL is required for remote management
* Libvirt: Restrict access to libvirt UNIX socket to authorized groups
* QEMU: Ensure QEMU processes run under an unprivileged user
* QEMU: Ensure KVM hardware acceleration modules are active
* QEMU: Verify memory management safety features are configured
* Hardening Spice security with TLS
* Apparmor
* Linux Host: Secure network IP forwarding behavior
* Ravada front
* Ravada back
* MySQL binlogs fill the disk


---

## Supported versions

- **Wazuh**: 4.14 or later (4.14.+ recommended)
- **Agents**: Linux (Debian/Ubuntu)
- **RavadaVDI**: 2.4.x

---

## Quick start

```bash
git clone 
cd sca_ravada_wazuh
sudo bash install.sh
```

The installer will:
1. Copy SCA policies to `/var/ossec/ruleset/sca/`
2. Copy detection rules to `/var/ossec/etc/rules/`
3. Update `ossec.conf` to enable the new SCA policies
4. Restart the Wazuh manager

---

## Manual installation

### 1. Copy SCA policies

Never place custom policies in /var/ossec/ruleset/sca — they get overwritten on upgrade!
On manager: /var/ossec/etc/shared/default/ (or group folder)

```bash
sudo cp sca/ravada_hardening.yml /var/ossec/etc/shared/default
```

### 2. Enable SCA policies in ossec.conf

Add the following inside the `<sca>` block in `/var/ossec/etc/ossec.conf`:

```xml
<sca>
  <enabled>yes</enabled>
  <scan_on_start>yes</scan_on_start>
  <interval>12h</interval>
  <skip_nfs>yes</skip_nfs>
  <policies>
    <policy>etc/shared/default/ravada_hardening.yml</policy>
  </policies>
</sca>
```

### 3. Copy detection rules

```bash
sudo cp rules/ravada_detection_rules.xml /var/ossec/etc/rules/
```

### 5. Restart Wazuh manager

```bash
sudo systemctl restart wazuh-manager
```

---

## Project structure
.
├── CONTRIBUTING.md
├── dashboard
├── docs
├── install.sh
├── LICENSE
├── README.md
├── rules
│   └── ravada_detection_rules.xml
├── sca
│   └── ravada_hardening.yml
└── tests
    └── validate_sca.py

---

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a pull request.

---

## References

- [RavadaVDI homepage](https://ravada.upc.edu)
- [Wazuh SCA Documentation](https://documentation.wazuh.com/current/user-manual/capabilities/sec-config-assessment/)
- [Wazuh Rules Documentation](https://documentation.wazuh.com/current/user-manual/ruleset/custom-rules/)
- [SCA test suite policies](https://github.com/wazuh/wazuh-qa/tree/master/tests/legacy/test_sca/test_basic_usage/data)
- [Available SCA policies](https://github.com/wazuh/wazuh/tree/main/ruleset/sca)
- [How SCA works](https://documentation.wazuh.com/current/user-manual/capabilities/sec-config-assessment/how-it-works.html)

---

## License

This project is licensed under the **GNU General Public License v2.0** — see [LICENSE](LICENSE) for details.

---

## Disclaimer & Terms of Use

> [!WARNING]
> ⚠️ **AS‑IS, NO WARRANTY**.

By using these guides, you agree to:

1. **Responsibility** - You must test and validate each recommendation yourself before applying it.
2. **No Liability** - The authors and contributors are **not liable** for any direct, indirect, or consequential damages arising from the use of this guidance.
3. **License** - All content is licensed under **AGPL3** (see [`LICENSE`](LICENSE)).  
4. **Community Techniques** - Some recommended practices are community-driven and **not officially supported** by Proxmox GmbH. Use at your own risk.

---

## Author

Maintained by ****Fernando Verdugo****, Wazuh entusiast.
