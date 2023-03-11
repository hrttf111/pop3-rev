# POP3 rev

This project is an attempt of reverse engineering of Populous: The Beginning (Pop3).
The main goal is to understand game resources and rendering. The main reverse engineering tool is Ghidra.

## Ghidra

Ghidra uses binary format to store project information and data. Project is big and small changes usually require to update the whole file. Since git does not natively support binary files, it leads to a fast repository growth.
To mitigate this issue, only XML exported data is stored in git. It is required to import it into Ghidra. Makefile contains commands to export/import project in different formats.

## Pop3

Analyzed binary is D3DPopTB.exe, it uses Direct3D as a renderer, so it gives an additional entry point for analysis. Project contains all functions and structures of Direct3D and DirectDraw, so nothing except original binary is needed.
Project DOES NOT contains code or data of Pop3 binary, there is only metadata. It is required to have an actual binary for import to work correctly.
