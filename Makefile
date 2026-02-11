.PHONY: help init install-pre-commit setup-python setup-node setup-go clean lint test

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
	@echo "$(BOLD)Initialization:$(RESET)"
	@echo "  $(GREEN)make init$(RESET)                - Initialize project with pre-commit (recommended first step)"
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
	@echo "  - Run '$(GREEN)make init$(RESET)' first to set up pre-commit"
	@echo "  - Then run language-specific targets: $(GREEN)setup-python$(RESET), $(GREEN)setup-node$(RESET), or $(GREEN)setup-go$(RESET)"
	@echo "  - Use '$(GREEN)make help$(RESET)' to see this message anytime"
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
	@command -v pre-commit >/dev/null 2>&1 || pip install pre-commit
	@echo "$(GREEN)✓ pre-commit installed$(RESET)"

# Setup Python environment
setup-python:
	@echo "$(BLUE)Setting up Python environment...$(RESET)"
	@python -m venv venv 2>/dev/null || python3 -m venv venv
	@echo "$(GREEN)✓ Virtual environment created$(RESET)"
	@echo ""
	@echo "Activate with: source venv/bin/activate (macOS/Linux) or venv\\Scripts\\activate (Windows)"
	@echo ""

# Setup Node.js environment
setup-node:
	@echo "$(BLUE)Setting up Node.js environment...$(RESET)"
	@command -v npm >/dev/null 2>&1 || (echo "$(YELLOW)Node.js/npm not found. Please install from https://nodejs.org$(RESET)" && exit 1)
	@npm install
	@echo "$(GREEN)✓ Node.js dependencies installed$(RESET)"

# Setup Go environment
setup-go:
	@echo "$(BLUE)Setting up Go environment...$(RESET)"
	@command -v go >/dev/null 2>&1 || (echo "$(YELLOW)Go not found. Please install from https://golang.org$(RESET)" && exit 1)
	@go mod download 2>/dev/null || go mod init module 2>/dev/null
	@echo "$(GREEN)✓ Go environment configured$(RESET)"

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