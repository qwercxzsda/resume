.DEFAULT_GOAL := check

TEX_FILES ?= $(sort $(wildcard *.tex))
CHKTEX ?= chktex
# Prefer Homebrew's self-contained Perl dependencies on macOS, if installed.
# Otherwise use the formatter supplied by the TeX distribution on PATH.
LATEXINDENT ?= $(firstword $(wildcard /opt/homebrew/bin/latexindent /usr/local/bin/latexindent) latexindent)
FORMAT_FLAGS := -l=.latexindent.yaml -c=.cache/latexindent/

.PHONY: check lint format format-check

check: lint format-check

lint:
	@# ChkTeX 1.7.9 can exit 0 after reporting end-of-file warnings.
	@lint_output="$$( $(CHKTEX) -q -l .chktexrc $(TEX_FILES) )"; lint_status=$$?; \
	if [ -n "$$lint_output" ]; then \
		printf '%s\n' "$$lint_output"; \
		exit 1; \
	fi; \
	exit "$$lint_status"

format:
	$(LATEXINDENT) $(FORMAT_FLAGS) -s -wd $(TEX_FILES)

format-check:
	$(LATEXINDENT) $(FORMAT_FLAGS) -s -kv $(TEX_FILES)
