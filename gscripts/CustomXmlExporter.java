import java.io.File;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

import ghidra.app.util.Option;
import ghidra.app.util.exporter.XmlExporter;
import ghidra.app.script.GhidraScript;

// See Ghidra/Features/Base/src/main/java/ghidra/app/util/exporter/XmlExporter.java
// See Ghidra/Features/Base/src/main/java/ghidra/app/util/xml/XmlProgramOptions.java
public class CustomXmlExporter extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        System.out.println("Script args: " + Arrays.toString(args));

        File outputFile = new File(args[0]);

        XmlExporter xmlExporter = new XmlExporter();
        List<Option> options = new ArrayList<Option>();
        //Exclude program binaries from export
        options.add(new Option("Memory Contents", new Boolean(false)));
        xmlExporter.setOptions(options);
        xmlExporter.setExporterServiceProvider(state.getTool());
        xmlExporter.export(outputFile, currentProgram, null, monitor);
    }
}
