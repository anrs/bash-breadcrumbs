# bash-breadcrumbs

Efficient navigation of your bash `cd` history for improved productivity.

## Installation

To install bash-breadcrumbs, run the following command:

```bash
curl -L https://raw.githubusercontent.com/anrs/bash-breadcrumbs/refs/heads/main/install.sh | bash
```

After installation, reload your bash configuration by running:

```bash
source ~/.bashrc
```

or

```bash
source ~/.bash_profile
```

## Usage

### List History: `cdl`

To view your recent directory history, use the `cdl` command:

![cdl](docs/static/cdl.png)

### Quick Jump: `cd*`

Use `cd` followed by the `number` shown in the history to quickly jump to a directory:

![cdx](docs/static/cdx.png)

### Known Issues

#### Emacs Comint: Directory Synchronization Issue

When using bash-breadcrumbs in Emacs' shell mode (bash), you may encounter an issue with directory completion. After navigating with `cd*`, attempting to autocomplete with <TAB> may produce a "No match" error. To fix this, navigate to the current directory again using the `cd` command, which refreshes Emacs comint's directory information.
