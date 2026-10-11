# Jeongho Son's resume

The resume uses Jake's Resume layout with Korean text support.

## Linting and formatting

Run these commands from the repository root:

```sh
make lint          # Check LaTeX with ChkTeX
make format        # Format source files with latexindent
make format-check  # Check formatting without changing source files
make check         # Run both checks (also the default for make)
```

The commands process every `.tex` file in the repository root. Both checks
return a nonzero exit status when they find a problem.

Formatting uses two spaces, recognizes the template's custom list macros, and
preserves line breaks. It does not change fonts, margins, or document wording.
Formatter logs and backups go in the ignored `.cache/latexindent/` directory.
ChkTeX is configured for the template's macros and date ranges;
it does not follow inputs from the TeX distribution.

## Requirements

MacTeX/TeX Live supplies `chktex` and `latexindent`. Verify both first:

```sh
chktex --version
latexindent --version
```

If MacTeX's formatter reports missing Perl modules, Homebrew's package includes
its Perl dependencies:

```sh
brew install latexindent
```

The Makefile prefers Homebrew's formatter when installed at a standard macOS
path, otherwise it uses `latexindent` from `PATH`. Either tool can be overridden:

```sh
make check LATEXINDENT=/Library/TeX/texbin/latexindent CHKTEX=/Library/TeX/texbin/chktex
```

Configuration references: [latexindent](https://latexindentpl.readthedocs.io/en/latest/)
and [ChkTeX](https://www.nongnu.org/chktex/).

## Build

Use pdfLaTeX for the canonical rendering:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error CV_JeonghoSon.tex
```

The output is `CV_JeonghoSon.pdf`. XeLaTeX is also supported for editor previews.
