import java.io.File;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.nio.file.AccessMode;
import java.util.Collection;

import ghidra.app.util.Option;
import ghidra.app.util.opinion.XmlLoader;
import ghidra.app.util.opinion.LoadSpec;
import ghidra.app.script.GhidraScript;
import ghidra.app.util.bin.FileByteProvider;
import ghidra.app.util.importer.MessageLog;
import ghidra.app.util.xml.XmlProgramOptions;

// See Ghidra/Features/Base/src/main/java/ghidra/app/util/exporter/XmlExporter.java
// See Ghidra/Features/Base/src/main/java/ghidra/app/util/xml/XmlProgramOptions.java
//
// See Ghidra/Features/Base/src/main/java/ghidra/plugin/importer/ImporterUtilities.java
// See Ghidra/Features/Base/src/main/java/ghidra/app/util/opinion/Loader.java
// See Ghidra/Features/Base/src/main/java/ghidra/app/util/opinion/XmlLoader.java
public class CustomXmlImporter extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        System.out.println("Script args: " + Arrays.toString(args));

        File inputFile = new File(args[0]);

        MessageLog ml = new MessageLog();
        FileByteProvider bp = new FileByteProvider(inputFile, null, AccessMode.READ);
        XmlLoader xmlLoader = new XmlLoader();
        boolean loadIntoProgram = true;
        List<Option> options = new XmlProgramOptions().getOptions(loadIntoProgram);
        Collection<LoadSpec> loadSpecs = xmlLoader.findSupportedLoadSpecs(bp);
        System.out.println("Spec collection size: " + String.valueOf(loadSpecs.size()));
        LoadSpec[] loadSpecsArray  = loadSpecs.toArray(new LoadSpec[0]);
        LoadSpec loadSpec = loadSpecsArray[0];
        xmlLoader.loadInto(bp, loadSpec, options, ml, currentProgram, monitor);
    }
}
