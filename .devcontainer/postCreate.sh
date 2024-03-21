gh auth login -h github.com --with-token < /home/vscode/secrets/gh_token.txt

# Update workspace environment
/home/vscode/.juliaup/bin/julia .devcontainer/postCreate.jl