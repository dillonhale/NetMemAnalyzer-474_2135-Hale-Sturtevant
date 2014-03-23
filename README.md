NetMemAnalyzer-474_2135-Hale-Sturtevant
=======================================

A memory analyzer that creates an image of a device’s memory, encrypts and sends to a server for further analysis.

We will be building a memory analyzer tool which creates an image of a device’s memory, encrypts and sends it to a server (where it will be further analyzed).

To verify the integrity of the memory image, we will generate a hash checksum and compare their values on the client as well as the server.

Our server application will consist of a GUI, which will allow the user to view specific items within the memory image (such as common credentials, images, etc.)

For our project, we will be using features from the following tools:

    Ncat
    Md5sum
    Sha256sum
    Fmem
