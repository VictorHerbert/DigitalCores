toolchain_install:
	wget https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-03-13/oss-cad-suite-linux-x64-20250313.tgz
	mkdir /opt/oss-cad-suite
	tar -xzf oss-cad-suite-linux-x64-20250313.tgz
	rm -rf oss-cad-suite-linux-x64-20250313.tgz