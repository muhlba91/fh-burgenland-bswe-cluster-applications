# FH Burgenland - BSWE - Demo Applications

[![Build status](https://img.shields.io/github/actions/workflow/status/muhlba91/fh-burgenland-bswe-cluster-applications/pipeline.yml?style=for-the-badge)](https://github.com/muhlba91/fh-burgenland-bswe-cluster-applications/actions/workflows/pipeline.yml)
[![License](https://img.shields.io/github/license/muhlba91/fh-burgenland-bswe-cluster-applications?style=for-the-badge)](LICENSE.md)

This repository contains demo applications for the course "Softwaremanagement II" at the FH Burgenland (BSWE) deployed on the `public-services-cluster` via [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) using [GitOps](https://opengitops.dev).

---

## Bootstrapping

The Kubernetes cluster needs to be bootstrapped with ArgoCD pointing to this repository.

---

## App-of-Apps

The repository follows the app-of-apps pattern.

The first `Application` being defined needs to reference [`app-of-apps/`](app-of-apps/).

These are bootstrapping the main applications, referring to the respective `kustomizations/<application>/` kustomizations:

- [`group`](#group): the BSWE group infrastructure

Each of these applications follows the app-of-apps pattern again, if necessary.

---

## Kustomizations

### Group

The `group` kustomization creates necessary infrastructure for one BSWE group. It is patched by an `ApplicationSet` defined in the `app-of-apps` application.

It defines the following resources:

- `Namespace`: the group's namespace
- `ResourceQuota`s: the group's namespace quotas (CPU, memory, storage, pods, services, etc.)
- `LimitRange`: the group's namespace limits (CPU, memory)
- `Secret`: the group's GHCR credentials (synchronized with the reflector)
- `AppProject`: the group's ArgoCD project
- `Application`: the group's ArgoCD app-of-apps application referencing the BSWE private repository

---

## Continuous Integration and Automations

- [GitHub Actions](https://docs.github.com/en/actions) are linting all YAML files.
- [Renovate Bot](https://github.com/renovatebot/renovate) is updating ArgoCD applications, container images, and GitHub Actions.
