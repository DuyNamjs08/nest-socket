import { BadRequestException, Injectable, PipeTransform } from '@nestjs/common';
import * as zod from 'zod';


@Injectable()
export class ValidationPipe implements PipeTransform {
  constructor(private schema: zod.ZodSchema) { }
  transform(value: any,) {
    const result = this.schema.safeParse(value);
    if (!result.success) {
      throw new BadRequestException(result.error.format());
    }
    return result.data
  }
}
