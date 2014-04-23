Include units containing Delphi translation of plugin API for AkelPad text editor.

`AkelDLL.pas` also contains helper functions for dealing with plugin parameters.
Usage manual & examples located in the end of source headers not included (refer to .h files for this info).

`AkelDLL.h` and `AkelEdit.h` are almost exact versions of the original API on which translated units are based. The only difference is addition of sections marked as `$$$ <section name> $$$`. Sections are used for automated conversion from C to Pas.

Semi-automated conversion
-------------------------

Header files could be semi-automatically converted into Pascal units. Script `gen_unit.njs` for Node.js takes template file (which contains constant parts of Pascal unit) and source header with section marks, extracts sections from the header, converts it to Pascal and inserts into template. The result is saved as .pas file. Note that only `#defines` are converted. Script also converts multiline OR's (...SOME_CONST |\ ...) but the conversion is incomplete so manual tuning is needed.