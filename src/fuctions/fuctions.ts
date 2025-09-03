
import * as path from 'path';

export function getMimeType(fileName: string): string {
  const ext = path.extname(fileName).toLowerCase();

  switch (ext) {
    case '.jpg':
    case '.jpeg':
      return 'image/jpeg';
    case '.png':
      return 'image/png';
    case '.gif':
      return 'image/gif';
    case '.webp':
      return 'image/webp';
    default:
      return 'application/octet-stream';
  }
}
