import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Response, Request } from 'express';
import * as fs from 'fs';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message = 'Internal server error';
    const file = request.file;
    if (file && file.path) {
      fs.unlink(file.path, (err) => {
        if (err) console.error('Error deleting file:', err);
        else console.log('Uploaded file deleted due to validation error');
      });
    }
    if (exception instanceof HttpException) {
      status = exception.getStatus();
      const res: any = exception.getResponse();
      if (typeof res === 'string') {
        message = res;
      } else if (Array.isArray(res.message)) {
        // ValidationPipe trả về mảng message
        message = res.message.join(', ');
      } else if (res.message) {
        message = res.message;
      } else if (res._errors) {
        // Zod error
        message = res._errors.join(', ');
      }
    }

    response.status(status).json({
      success: false,
      statusCode: status,
      message,
      path: request.url,
      timestamp: new Date().toISOString(),
    });
  }
}
