GHIDRA_PATH?=/nix/store/68g6ighr2pr0j85hdp1zlc2mdrxqj37w-ghidra-10.2.2/lib/ghidra/
GHIDRA_HEADLESS=$(GHIDRA_PATH)/support/analyzeHeadless
CURRENT_DIR=$(shell pwd)
SCRIPT_PATH=$(CURRENT_DIR)/gscripts
XML_BACKUP_PATH=$(CURRENT_DIR)/backup
ARCHIVE_BACKUP_PATH?=/opt/shared/ghidra
DEST_XML=backup.xml
DEST_GZF=backup.gzf
BIN_PATH?="$(shell realpath ~/.wine/drive_c/GOG\ Games/Populous\ 3/D3DPopTB.exe)"
PROJECT_PATH=$(CURRENT_DIR)/ghidra
PROJECT_PATH_IMPORT=$(PROJECT_PATH)
PROJECT_NAME=pop3

BIN_HASH="815ba8a550f571c38b602cf3386f65aab942667a4a2d9c7096b3660deac2eacd *$(BIN_PATH)"

all: export_xml

check_hash:
	$(shell echo $(BIN_HASH) | sha256sum -c -)

export_xml:
	$(GHIDRA_HEADLESS) $(PROJECT_PATH) $(PROJECT_NAME) \
		-process -readOnly -noanalysis \
		-scriptPath $(SCRIPT_PATH) \
		-postscript CustomXmlExporter.java $(XML_BACKUP_PATH)/$(DEST_XML)

export_gzf:
	$(GHIDRA_HEADLESS) $(PROJECT_PATH) $(PROJECT_NAME) \
		-process -readOnly -noanalysis \
		-scriptPath $(SCRIPT_PATH) \
		-postscript CustomGzfExporter.java $(ARCHIVE_BACKUP_PATH)/$(DEST_GZF)

export_tgz:
	tar -czf $(ARCHIVE_BACKUP_PATH)/pop3_backup_$(shell date +%m.%d.%y).tar.gz $(PROJECT_PATH)

empty_project: ghidra
	$(GHIDRA_HEADLESS) $(PROJECT_PATH_IMPORT) $(PROJECT_NAME) \
		-import $(BIN_PATH) -noanalysis

import_xml: empty_project
	$(GHIDRA_HEADLESS) $(PROJECT_PATH_IMPORT) $(PROJECT_NAME) \
		-process -overwrite -noanalysis \
		-scriptPath $(SCRIPT_PATH) \
		-postscript CustomXmlImporter.java $(XML_BACKUP_PATH)/$(DEST_XML)

ghidra:
	mkdir ghidra

clean:
	rm -f backup.bytes $(DEST_GZF) $(DEST_XML)

.PHONY: export_xml export_gzf empty_project import_xml clean
