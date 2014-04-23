// Script for converting C header file to Delphi unit
// Actually converts only defines

var fs = require('fs');
var path = require('path');

var files = {
	tpl: '',
	hdr: '',
	pas: ''
}
var baseName = path.resolve(__dirname, process.argv[2]);

files.hdr = fs.readFileSync(baseName+'.h', {encoding: 'utf8'});
files.tpl = fs.readFileSync(baseName+'.tpl', {encoding: 'utf8'});
files.pas = files.tpl;

var fromPos = 0;
while (true)
{
	// search for "$$$ <section name> $$$" in template

	var sectBeg = files.tpl.indexOf('$$$', fromPos);
	if (sectBeg == -1) break;
	var sectEnd = files.tpl.indexOf('$$$', sectBeg + 3);
	if (sectEnd == -1) break;
	var sectName = files.tpl.substring(sectBeg + 3, sectEnd).trim();
	fromPos = sectEnd + 3;
	console.log('Found section ' + sectName);
	
	// extract everything between "$$$ <section name> $$$" and "$$$ <section name> END $$$" in header

	sectBeg = files.hdr.indexOf('$$$ '+sectName+' $$$');
	if (sectBeg == -1)
	{
		console.log('No '+sectName+' section found in header');
		continue;
	}
	sectEnd = files.hdr.indexOf('$$$ '+sectName+' END $$$', sectBeg);
	if (sectEnd == -1)
	{
		console.log('No '+sectName+' END found in header');
		continue;
	}
	var sectContent = files.hdr.substring(sectBeg+('$$$ '+sectName+' $$$').length, sectEnd);
	
	// perform replacements
	
	// 1) multiline |'s => or's, #define => const, 0x => $
	sectContent = sectContent.replace(/\|\\$/gm, 'or');
	sectContent = sectContent.replace(/#define ([\w_]+)(\s+)(.+?)(\s*)(\/\/|$)/gm, 'const $1$2= $3;$4$5');
	sectContent = sectContent.replace(/const ([\w_]+)(\s+)= 0x(.+?);/gm, 'const $1$2= $$$3;');
	
	// 2) ...
	
	
	// replace the section in template by its content
	files.pas = files.pas.replace('$$$ '+sectName+' $$$', sectContent);
} // while

fs.writeFileSync(baseName + '.pas', files.pas);
console.log('Unit file saved as '+baseName + '.pas');