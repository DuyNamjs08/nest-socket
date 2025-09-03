import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true, collection: 'product_clicks' })
export class ProductClick extends Document {
    @Prop({ required: true })
    product_id: number; // ID sản phẩm (tham chiếu từ hệ thống sản phẩm của bạn)

    @Prop({ required: true, default: 0 })
    count: number; // số lượt click

    @Prop({ required: true })
    user_id: number; // ai click (nếu muốn tracking theo user)

    @Prop({ required: true })
    user_email: string; // ai click (nếu muốn tracking theo user)

    @Prop({ required: false })
    ip?: string; // địa chỉ IP (chống spam click)

    @Prop({ type: Date, default: Date.now })
    clicked_at: Date; // thời điểm click
}

export const ProductClickSchema = SchemaFactory.createForClass(ProductClick);
ProductClickSchema.index({ user_id: 1, product_id: 1 });
