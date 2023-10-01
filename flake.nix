{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};
	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem
			(system:
				let
					pkgs = import nixpkgs {
						inherit system;
					};
					pypkgs = ps: with ps; [
						mkdocs
						mkdocs-material
						mkdocs-material-extensions
						mkdocs-git-revision-date-localized-plugin
						#mkdocs-glightbox
					];
				in
				with pkgs;
				{
					devShells.default = mkShell {
						packages = [
							(python311.withPackages pypkgs)
						];
					};
				}
			);

}
