<div align="center">
  <img src="https://raw.githubusercontent.com/singularityos-lab/brand/refs/heads/main/Icon.png" height="120">
  <h1 align="center">Singularity OS Desktop</h1>
  <p align="center">Containerfile for building a Singularity OS Desktop image.</p>
</div>

This image is based on top of [`vanillaos/core`](https://github.com/Vanilla-OS/core-image/pkgs/container/core) and offers the default
Singularity OS Desktop experience with GNOME.

## Build

> [!NOTE]
> The fsguard compiled plugin `.so` file should be downloaded from the [latest release](https://github.com/Vanilla-OS/vib-fsguard/releases/latest) and be placed under a `plugins` directory beside the `recipe.yml` file.

```bash
vib build recipe.yml
podman image build -t singularityos-lab/desktop .
```

## Verify Image Build Provenance Attestation

All the image builds/pushes are attested for build provenance and integrity using the [attest-build-provenance](https://github.com/actions/attest-build-provenance) action. The attestations can be verified [here](https://github.com/singularityos-lab/desktop-image/attestations) or by having the latest version of [GitHub CLI](https://github.com/cli/cli/releases/latest) installed in your system. Then, execute the following command:

```sh
gh attestation verify oci://ghcr.io/singularity-os/desktop:main --owner singularityos-lab
```
