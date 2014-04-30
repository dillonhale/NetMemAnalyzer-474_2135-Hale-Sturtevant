NetMemAnalyzer-474_2135-Hale-Sturtevant
=======================================

Overview:
NetMemAnalyzer is a client/server memory analyzer that creates an image of a device’s memory and sends it to a server for further analysis.

Its main features include:
 * Search for specific s
 * Extraction of JPG, PNG and GIF files from memory image

Requirements:
Our application is currently supported on UNIX/Linux Operating Systems:
 * Kali Linux
 * Other versions of Linux have not been tested yet, although may still be compatible.

The following extensions are required to use NetMemAnalyzer:
 * Perl
 * Ncat
 * Fmem

Installation:
Server:
 - Prior to starting the NetMemAnalyzer Server, ensure that Perl is installed with the perk tk module.
 - Start the server script
 - Make note of the listening port for use on your client machine

Client:
The client was built to have less overhead and to preserve as much memory evidence as possible. 
 - Prior to starting the NetMemAnalyzer Client. ensure that Perl is installed as well as fmem.
 - Start the client script and entert the connection information for the server
 
Analyzing Memory Images:
 - Scan for Strings - this option prompts with a dialog box that allows the investigator to search the memory image for specific string values

 - Save Images Locally Checkbox - by default, NetMemAnalyzer carves file data from the memory image without saving the located files to the investigators machine. The data is then compared to a list of known bad file checksums. If you would like to save any carved file data to the investigators local machine - check this box
 - Carve JPG
 - Carve PDF
 - Carve GIF
