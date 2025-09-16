
import fs from 'fs';
import { Dropbox } from 'dropbox';
import AdmZip  from 'adm-zip';

// Initialize Dropbox client with your access token
const dbx = new Dropbox({ 
  accessToken: process.env.DROPBOX_ACCESS_TOKEN ,
  selectUser: process.env.DROPBOX_APP_USER
});

async function downloadFolderAsZip(folderPath, outputPath) {
  try {
    console.log(`Dropbox access token is ${process.env.DROPBOX_ACCESS_TOKEN.slice(5)}`);
    const response = await dbx.filesDownloadZip({ path: folderPath });
    // response.result.fileBinary contains the zip file data
    fs.writeFileSync('./out.zip', response.result.fileBinary, 'binary');

    const zip = new AdmZip('./out.zip');
    zip.extractAllTo(outputPath, true);
    fs.unlinkSync('./out.zip')
    console.log(`Downloaded all files to ${outputPath}`);
  } catch (error) {
    console.error('Error downloading folder:', error);
    process.exit(1);
  }
}

downloadFolderAsZip('/public/galleries', './src/assets/');
