.PHONY: help init install-pre-commit setup-python setup-node setup-go clean lint test check-prereqs detect-language setup

# Color output
BOLD := \033[1m
BLUE := \033[34m
GREEN := \033[32m
YELLOW := \033[33m
CYAN := \033[36m
MAGENTA := \033[35m
WHITE := \033[37m
RESET := \033[0m

help:
	@echo "$(BOLD)$(BLUE)Makefile Template - Available Targets$(RESET)"
	@echo ""
	@echo "$(BOLD)🚀 Quick Start (Recommended):$(RESET)"
	@echo "  $(GREEN)make setup$(RESET)               - Auto-detect and setup everything"
	@echo "  $(GREEN)make check-prereqs$(RESET)       - Check if required tools are installed"
	@echo ""
	@echo "$(BOLD)Initialization:$(RESET)"
	@echo "  $(GREEN)make init$(RESET)                - Initialize project with pre-commit"
	@echo "  $(GREEN)make install-pre-commit$(RESET)  - Install pre-commit hooks"
	@echo ""
	@echo "$(BOLD)Language Setup:$(RESET)"
	@echo "  $(GREEN)make setup-python$(RESET)        - Setup Python environment (venv, pip)"
	@echo "  $(GREEN)make setup-node$(RESET)          - Setup Node.js environment (node_modules)"
	@echo "  $(GREEN)make setup-go$(RESET)            - Setup Go environment (dependencies)"
	@echo ""
	@echo "$(BOLD)Development:$(RESET)"
	@echo "  $(GREEN)make lint$(RESET)                - Run linters (requires pre-commit hooks)"
	@echo "  $(GREEN)make test$(RESET)                - Run tests"
	@echo "  $(GREEN)make clean$(RESET)               - Clean temporary files and caches"
	@echo ""
	@echo "$(BOLD)Notes:$(RESET)"
	@echo "  - First time? Run '$(GREEN)make setup$(RESET)' - it does everything!"
	@echo "  - Use '$(GREEN)make help$(RESET)' to see this message anytime"
	@echo ""

# Check prerequisites
check-prereqs:
	@echo "$(BLUE)Checking prerequisites...$(RESET)"
	@echo ""
	@command -v git >/dev/null 2>&1 && echo "$(GREEN)✓ Git installed$(RESET)" || echo "$(YELLOW)✗ Git not found - Install from https://git-scm.com$(RESET)"
	@command -v python >/dev/null 2>&1 && echo "$(GREEN)✓ Python installed ($(shell python --version 2>&1))$(RESET)" || command -v python3 >/dev/null 2>&1 && echo "$(GREEN)✓ Python installed ($(shell python3 --version 2>&1))$(RESET)" || echo "$(YELLOW)✗ Python not found - Install from https://python.org$(RESET)"
	@command -v pip >/dev/null 2>&1 && echo "$(GREEN)✓ pip installed$(RESET)" || command -v pip3 >/dev/null 2>&1 && echo "$(GREEN)✓ pip3 installed$(RESET)" || echo "$(YELLOW)✗ pip not found - Install Python with pip$(RESET)"
	@command -v node >/dev/null 2>&1 && echo "$(GREEN)✓ Node.js installed ($(shell node --version 2>&1))$(RESET)" || echo "$(CYAN)ℹ Node.js not installed (optional) - Install from https://nodejs.org$(RESET)"
	@command -v npm >/dev/null 2>&1 && echo "$(GREEN)✓ npm installed$(RESET)" || echo "$(CYAN)ℹ npm not installed (optional)$(RESET)"
	@command -v go >/dev/null 2>&1 && echo "$(GREEN)✓ Go installed ($(shell go version 2>&1))$(RESET)" || echo "$(CYAN)ℹ Go not installed (optional) - Install from https://golang.org$(RESET)"
	@command -v make >/dev/null 2>&1 && echo "$(GREEN)✓ Make installed$(RESET)" || echo "$(YELLOW)✗ Make not found$(RESET)"
	@echo ""

# Detect project language
detect-language:
	@if [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ] || [ -f "Pipfile" ]; then \
		echo "python"; \
	elif [ -f "package.json" ]; then \
		echo "node"; \
	elif [ -f "go.mod" ] || [ -f "go.sum" ]; then \
		echo "go"; \
	else \
		echo "none"; \
	fi

# Auto-detect and setup everything (one command setup)
setup: check-prereqs
	@echo ""
	@echo "$(BOLD)$(BLUE)🚀 AUTO-SETUP - Detecting and configuring...$(RESET)"
	@echo ""
	@$(MAKE) init
	@LANG=$$(if [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ] || [ -f "Pipfile" ]; then echo "python"; \
		elif [ -f "package.json" ]; then echo "node"; \
		elif [ -f "go.mod" ] || [ -f "go.sum" ]; then echo "go"; \
		else echo "none"; fi); \
	if [ "$$LANG" = "python" ]; then \
		echo ""; \
		echo "$(BLUE)📦 Python project detected - setting up...$(RESET)"; \
		$(MAKE) setup-python; \
	elif [ "$$LANG" = "node" ]; then \
		echo ""; \
		echo "$(BLUE)📦 Node.js project detected - setting up...$(RESET)"; \
		$(MAKE) setup-node; \
	elif [ "$$LANG" = "go" ]; then \
		echo ""; \
		echo "$(BLUE)📦 Go project detected - setting up...$(RESET)"; \
		$(MAKE) setup-go; \
	fi
	@echo ""
	@echo "$(GREEN)$(BOLD)✅ SETUP COMPLETE!$(RESET)"
	@echo ""
	@echo "$(BOLD)You're ready to code securely! 🎉$(RESET)"
	@echo ""

# Initialize project with pre-commit
init: install-pre-commit
	@echo ""
	@echo "$(BLUE)███████╗███████╗ ██████╗██╗   ██╗██████╗ ███████╗$(RESET)"
	@echo "$(BLUE)██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██╔════╝$(RESET)"
	@echo "$(CYAN)███████╗█████╗  ██║     ██║   ██║██████╔╝█████╗  $(RESET)"
	@echo "$(CYAN)╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██╔══╝  $(RESET)"
	@echo "$(GREEN)███████║███████╗╚██████╗╚██████╔╝██║  ██║███████╗$(RESET)"
	@echo "$(GREEN)╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝$(RESET)"
	@echo ""
	@echo "$(GREEN)✅ Project initialized with pre-commit!$(RESET)"
	@echo ""
	@echo "$(BOLD)Your repository is now protected against:$(RESET)"
	@echo "$(GREEN)  🔑 API Keys & tokens$(RESET)"
	@echo "$(GREEN)  🔐 Database passwords$(RESET)"
	@echo "$(GREEN)  🗝️  Private keys (SSH, PGP)$(RESET)"
	@echo "$(GREEN)  🎫 OAuth credentials$(RESET)"
	@echo ""
	@echo "$(BOLD)Next steps:$(RESET)"
	@echo "1. Choose your language and run the setup command:"
	@echo "   - $(GREEN)make setup-python$(RESET)"
	@echo "   - $(GREEN)make setup-node$(RESET)"
	@echo "   - $(GREEN)make setup-go$(RESET)"
	@echo ""
	@echo "2. Configure .pre-commit-config.yaml for your project"
	@echo "3. Try committing a fake .env file - the hook will block it! ✨"
	@echo ""

# Install pre-commit
install-pre-commit:
	@echo "$(BLUE)Installing pre-commit...$(RESET)"
	@if ! command -v pip >/dev/null 2>&1 && ! command -v pip3 >/dev/null 2>&1; then \
		echo "$(YELLOW)✗ pip not found. Please install Python and pip first:$(RESET)"; \
		echo "  - macOS: brew install python"; \
		echo "  - Ubuntu/Debian: sudo apt install python3-pip"; \
		echo "  - Windows: Download from https://python.org"; \
		exit 1; \
	fi
	@command -v pre-commit >/dev/null 2>&1 || (command -v pip >/dev/null 2>&1 && pip install pre-commit) || pip3 install pre-commit
	@pre-commit install
	@echo "$(GREEN)✓ pre-commit installed and hooks configured$(RESET)"

# Setup Python environment
setup-python:
	@echo "$(BLUE)Setting up Python environment...$(RESET)"
	@if ! command -v python >/dev/null 2>&1 && ! command -v python3 >/dev/null 2>&1; then \
		echo "$(YELLOW)✗ Python not found. Please install Python first:$(RESET)"; \
		echo "  - macOS: brew install python"; \
		echo "  - Ubuntu/Debian: sudo apt install python3"; \
		echo "  - Windows: Download from https://python.org"; \
		exit 1; \
	fi
	@python -m venv venv 2>/dev/null || python3 -m venv venv
	@echo "$(GREEN)✓ Virtual environment created$(RESET)"
	@if [ -f "requirements.txt" ]; then \
		echo "$(BLUE)Installing Python dependencies from requirements.txt...$(RESET)"; \
		./venv/bin/pip install -r requirements.txt 2>/dev/null || venv/Scripts/pip install -r requirements.txt 2>/dev/null || echo "$(YELLOW)Note: Activate venv and run: pip install -r requirements.txt$(RESET)"; \
		echo "$(GREEN)✓ Dependencies installed$(RESET)"; \
	fi
	@echo ""
	@echo "$(BOLD)Next steps:$(RESET)"
	@echo "  - macOS/Linux: source venv/bin/activate"
	@echo "  - Windows: venv\\Scripts\\activate"
	@echo ""

# Setup Node.js environment
setup-node:
	@echo "$(BLUE)Setting up Node.js environment...$(RESET)"
	@if ! command -v npm >/dev/null 2>&1; then \
		echo "$(YELLOW)✗ Node.js/npm not found. Please install Node.js:$(RESET)"; \
		echo "  - macOS: brew install node"; \
		echo "  - Ubuntu/Debian: sudo apt install nodejs npm"; \
		echo "  - Windows: Download from https://nodejs.org"; \
		exit 1; \
	fi
	@if [ -f "package.json" ]; then \
		npm install; \
		echo "$(GREEN)✓ Node.js dependencies installed$(RESET)"; \
	else \
		echo "$(YELLOW)No package.json found - skipping npm install$(RESET)"; \
		echo "$(CYAN)Tip: Run 'npm init' to create a package.json$(RESET)"; \
	fi

# Setup Go environment
setup-go:
	@echo "$(BLUE)Setting up Go environment...$(RESET)"
	@if ! command -v go >/dev/null 2>&1; then \
		echo "$(YELLOW)✗ Go not found. Please install Go:$(RESET)"; \
		echo "  - macOS: brew install go"; \
		echo "  - Ubuntu/Debian: sudo apt install golang"; \
		echo "  - Windows: Download from https://golang.org"; \
		exit 1; \
	fi
	@if [ -f "go.mod" ]; then \
		go mod download; \
		echo "$(GREEN)✓ Go dependencies downloaded$(RESET)"; \
	else \
		echo "$(YELLOW)No go.mod found - initializing new module$(RESET)"; \
		go mod init module; \
		echo "$(GREEN)✓ Go module initialized$(RESET)"; \
	fi

# Run linters via pre-commit
lint:
	@echo "$(BLUE)Running linters...$(RESET)"
	@pre-commit run --all-files
	@echo "$(GREEN)✓ Linting complete$(RESET)"

# Run tests (customize based on your setup)
test:
	@echo "$(BLUE)Running tests...$(RESET)"
	@echo "$(YELLOW)Note: Customize test command in Makefile for your project$(RESET)"
	@echo "Examples:"
	@echo "  - Python: pytest"
	@echo "  - Node.js: npm test"
	@echo "  - Go: go test ./..."

# Clean temporary files
clean:
	@echo "$(BLUE)Cleaning temporary files...$(RESET)"
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "node_modules" -not -path "./node_modules" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type f -name ".DS_Store" -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Cleanup complete$(RESET)"

.DEFAULT_GOAL := help