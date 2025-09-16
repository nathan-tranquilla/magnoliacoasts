
import fs from 'fs';
import { Dropbox } from 'dropbox';
import AdmZip  from 'adm-zip';
import {execSync} from 'child_process'

// Initialize Dropbox client with your access token
const dbx = new Dropbox({ 
  accessToken: process.env.DROPBOX_ACCESS_TOKEN ,
  selectUser: process.env.DROPBOX_APP_USER
});

async function downloadFolderAsZip(folderPath, outputPath) {
  try {
    const response = await dbx.filesDownloadZip({ path: folderPath });
    fs.writeFileSync('./out.zip', response.result.fileBinary, 'binary');
    // Print size of zip file
    const zipStats = fs.statSync('./out.zip');
    const zipSizeBytes = zipStats.size;
    const zipSizeMB = (zipSizeBytes / (1024 * 1024)).toFixed(2);
    console.log(`Downloaded zip size: ${zipSizeBytes} bytes (${zipSizeMB} MB)`);

    const zip = new AdmZip('./out.zip');
    var zipEntries = zip.getEntries(); // an array of ZipEntry records - add password parameter if entries are password protected
    zipEntries.forEach(function (zipEntry) {
      console.log(zipEntry.entryName); // outputs zip entries information
    });
    zip.extractAllTo(outputPath, true);
    fs.unlinkSync('./out.zip');
    
    console.log(`Downloaded all files to ${outputPath}galleries`);

    try {
      let cmd = `find ${outputPath}galleries -type f -name '*.jpg'`
      console.log(cmd)
      const result = execSync(`find ${outputPath}galleries -type f -name '*.jpg'`, { encoding: 'utf8' });
      console.log('Downloaded gallery files:');
      console.log(result.trim());
    } catch (err) {
      console.error('Error running find for .jpg files:', err);
    }
  } catch (error) {
    console.error('Error downloading folder:', error);
    process.exit(1);
  }
}

downloadFolderAsZip('/public/galleries', './src/assets/');
