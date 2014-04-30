NetMemAnalyzer-474_2135-Hale-Sturtevant
=======================================

##Overview:
NetMemAnalyzer is a client/server memory analyzer that creates an image of a device’s memory and sends it to a server for further analysis.

##Main Features:
 * Search for specific strings
 * Extraction of JPG, PNG and GIF files from memory image

##Requirements:
Our application is currently supported on UNIX/Linux Operating Systems:
 * Kali Linux
 * Other versions of Linux have not been tested yet, although may still be compatible.

The following extensions are required to use NetMemAnalyzer:
 * Perl
 * Ncat
 * Fmem

##Installation and Use:
Server:
 - Prior to starting the NetMemAnalyzer Server, ensure that Perl is installed with the perk tk module.
 - Start the server script
 - Make note of the listening port for use on your client machine

   Analyzing Memory Images:
    - Scan for Strings - this option prompts with a dialog box that allows the investigator to search the memory image for specific string values
   
    - Save Images Locally Checkbox - by default, NetMemAnalyzer carves file data from the memory image without saving the located files to the investigators machine. If you would like to save the carved file data to the investigators local machine - check this box
   
   
    - Carve JPG, PNG, GIF - The carve options extracts  file data from the memory image and compares it against a list of known bad hashes. The investigator is alerted when a known bad file is located. 

Client:
The client was built to have less overhead and to preserve as much memory evidence as possible. 
 - Prior to starting the NetMemAnalyzer Client. ensure that Perl is installed as well as fmem.
 - Start the client script and entert the connection information for the server


##Known Bugs:
May not extract partial files from memory, only searches for start and end of file signature. 

##License
This program and all source code is released under GPLv2. Please see LICENSE included with this distribution for more information.

##Authors
This application was created as an assignment for our Unix Forensics class at Rochester Institute of Technology. If you have any questions, comments or would like to contribute to this project, feel free to reach out to one of us.

- Dillon Hale - Drh9473@rit.edu - www.dillonhale.com
- Alicia Sturtevant - Aas5999@rit.edu
