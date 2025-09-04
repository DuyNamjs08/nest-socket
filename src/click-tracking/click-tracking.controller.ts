import { Controller, Get, Param, Post } from "@nestjs/common";
import { ClickProducerService } from "./click-tracking.service";




@Controller('api/v1/products-count')
export class ClickTrackingController {
    constructor(private readonly clickProducerService: ClickProducerService) { }

    @Get(':user_id')
    async trackClickList(@Param('user_id') user_id: string) {
        const result = await this.clickProducerService.getListCountClickByUserProduct(Number(user_id));
        return result;
    }
}