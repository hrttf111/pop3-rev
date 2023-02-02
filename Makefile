GHIDRA_PATH=/nix/store/68g6ighr2pr0j85hdp1zlc2mdrxqj37w-ghidra-10.2.2/lib/ghidra/
CURRENT_DIR=$(shell pwd)
PROJECT_PATH=$(CURRENT_DIR)/ghidra
SCRIPT_PATH=$(CURRENT_DIR)/gscripts
DEST_XML=backup.xml
DEST_GZF=backup.gzf
XML_BACKUP_PATH=$(CURRENT_DIR)/backup
ARCHIVE_BACKUP_PATH=/opt/shared/ghidra

BIN_PATH="/home/ddd/.wine/drive_c/GOG Games/Populous 3/D3DPopTB.exe"
PROJECT_PATH_IMPORT=$(PROJECT_PATH)

all: export_xml

export_xml:
	$(GHIDRA_PATH)/support/analyzeHeadless $(PROJECT_PATH) pop3 \
		-process -readOnly -noanalysis \
		-scriptPath $(SCRIPT_PATH) \
		-postscript CustomXmlExporter.java $(XML_BACKUP_PATH)/$(DEST_XML)

export_gzf:
	$(GHIDRA_PATH)/support/analyzeHeadless $(PROJECT_PATH) pop3 \
		-process -readOnly -noanalysis \
		-scriptPath $(SCRIPT_PATH) \
		-postscript CustomGzfExporter.java $(ARCHIVE_BACKUP_PATH)/$(DEST_GZF)

export_tgz:
	tar -czf $(ARCHIVE_BACKUP_PATH)/pop3_backup_$(shell date +%m.%d.%y).tar.gz $(PROJECT_PATH)

empty_project: ghidra
	$(GHIDRA_PATH)/support/analyzeHeadless $(PROJECT_PATH_IMPORT) pop3 \
		-import $(BIN_PATH) -noanalysis

import_xml: empty_project
	$(GHIDRA_PATH)/support/analyzeHeadless $(PROJECT_PATH_IMPORT) pop3 \
		-process -overwrite -noanalysis \
		-scriptPath $(SCRIPT_PATH) \
		-postscript CustomXmlImporter.java $(XML_BACKUP_PATH)/$(DEST_XML)

ghidra:
	mkdir ghidra

clean:
	rm -f backup.bytes $(DEST_GZF) $(DEST_XML)

.PHONY: export_xml export_gzf empty_project import_xml clean
