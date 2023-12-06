from pelinker import COFF, Executable
import sys

with open(sys.argv[1], 'rb') as handle:
    coff = COFF(handle.read())

exe = Executable()

for section_name, section_permission, section_data, relocation in coff.sections:
    new_section = exe.add_section(section_name, section_permission, section_data)
    if section_name ==".text":
        exe.entry_point = new_section.rva
    for reloc_name, reloc_offset, reloc_type in relocation:
        new_section.add_relocation_symbol(reloc_name, reloc_offset, reloc_type)

exe.import_symbols("user32.dll",["MessageBeep", "MessageBoxA"])
exe.import_symbols("kernel32.dll",["ExitProcess"])
exe.import_symbols("raylib.dll",
                   [
                       "InitWindow",
                       "BeginDrawing",
                       "ClearBackground",
                       "DrawText",
                       "WindowShouldClose",
                       "SetTargetFPS",
                       "DrawRectangle",
                       "IsKeyDown",
                       "EndDrawing",
                       "CloseWindow",
                        "DrawEllipse" ])

with open(sys.argv[2], 'wb') as handle:
    handle.write(exe.link())

