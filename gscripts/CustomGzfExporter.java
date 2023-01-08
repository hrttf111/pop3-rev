import java.io.File;
import java.util.Arrays;

import ghidra.app.util.Option;
import ghidra.app.util.exporter.GzfExporter;
import ghidra.app.script.GhidraScript;

// See Ghidra/Features/Base/src/main/java/ghidra/app/util/exporter/GzfExporter.java
public class CustomGzfExporter extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        System.out.println("Script args: " + Arrays.toString(args));

        File outputFile = new File(args[0]);

        GzfExporter gzfExporter = new GzfExporter();
        gzfExporter.setExporterServiceProvider(state.getTool());
        gzfExporter.export(outputFile, currentProgram, null, monitor);
    }
}
