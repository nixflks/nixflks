# nixflks

[![Nix Flakes: Test](../../actions/workflows/nix-flakes-test.yml/badge.svg)](../../actions/workflows/nix-flakes-test.yml)

Nix Flakes Collection.

## 📜 Overview

### Available Packages

The following packages are available for use.

<table>
  <thead>
    <tr>
      <th>Package</th>
      <th>Description</th>
      <th>Directory</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <strong><code>hacker-news-to-sqlite</code></strong>
      </td>
      <td>Create a SQLite database containing data pulled from Hacker News.</td>
      <td><code>pkgs/hacker-news-to-sqlite</code></td>
    </tr>
    <tr>
      <td>
        <strong><code>paginate-json</code></strong>
      </td>
      <td>CLI tool for retrieving JSON from paginated APIs.</td>
      <td><code>pkgs/paginate-json</code></td>
    </tr>
  </tbody>
</table>

## 🚀 Usage

### Command

<table>
  <thead>
    <tr>
      <th>Package</th>
      <th>Command</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <strong><code>hacker-news-to-sqlite</code></strong>
      </td>
      <td><code>nix run github:nixflks/nixflks#hacker-news-to-sqlite -- --version</code></td>
    </tr>
    <tr>
      <td>
        <strong><code>paginate-json</code></strong>
      </td>
      <td><code>nix run github:nixflks/nixflks#paginate-json -- --version</code></td>
    </tr>
  </tbody>
</table>

### Flake Input

To use the packages in your own `flake.nix`, add `nixflks` to your inputs.

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    nixflks = {
      url = "github:nixflks/nixflks";
      # Follow the nixpkgs of your project for consistency
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixflks, ... }@inputs: {
    # You can now reference packages like nixflks.packages.<system>.hacker-news-to-sqlite
  };
}
```

## 📖 Documentation

Below you will find a list of documentation for tools used in this project.

- **Nix**: Nix Package Manager - [Docs](https://nixos.org)
- **GitHub Actions**: Automation and Execution of Software Development Workflows - [Docs](https://docs.github.com/en/actions)

## 🐛 Found a Bug?

Thank you for your message! Please fill out a [bug report](../../issues/new?assignees=&labels=&template=bug_report.md&title=).

## 📖 License

This project is licensed under the [European Union Public License 1.2](https://interoperable-europe.ec.europa.eu/collection/eupl/eupl-text-eupl-12).