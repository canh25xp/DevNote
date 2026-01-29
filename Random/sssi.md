---
id: sssi
aliases: []
tags: []
---

# SSSI (Samsung Single System Image)

## Why `wpa_supplicant` must be build on vendor template

### Why wpa_supplicant must be built on the vendor side:

- The actual `wpa_supplicant` module that gets loaded onto devices comes from the **Vendor workspace**
- Code from the Vendor workspace is used to create the `wpa_supplicant` module that is actually deployed on phones
- This is the implementation that runs on the final product

### Why it's still needed on the system side:

- The `wpa_supplicant` code in the **System workspace** exists only to ensure successful system builds
- During System builds, `wpa_supplicant` generates output but this output is **discarded**
- It's included purely for build success requirements - not for actual deployment
- Without it, the System build would fail even though the generated output isn't used

### Key Takeaway

For both new models and OS upgrade models, always reference the **Vendor workspace** for the correct `wpa_supplicant` implementation, as the System workspace version serves only as a build dependency that gets discarded.
