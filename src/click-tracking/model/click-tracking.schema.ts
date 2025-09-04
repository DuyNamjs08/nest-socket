import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { format } from 'date-fns';
import { toZonedTime } from 'date-fns-tz';

export type ProductClickDocument = ProductClick & Document;

@Schema({ timestamps: true, collection: 'product_clicks' })
export class ProductClick {
    @Prop({ required: true })
    product_id: number;

    @Prop({ required: true, default: 0 })
    count: number;

    @Prop({ required: true })
    user_id: number;

    @Prop({ required: true })
    user_email: string;

    @Prop({ required: false })
    ip?: string;

    @Prop({ type: Date, default: Date.now })
    clicked_at: Date;

    // Mongo auto-add khi timestamps: true
    createdAt: Date;
    updatedAt: Date;

    // Virtuals để TS nhận diện
    created_at?: string;
    updated_at?: string;
}

export const ProductClickSchema = SchemaFactory.createForClass(ProductClick);

// Index tối ưu
ProductClickSchema.index({ user_id: 1, product_id: 1 });

// Timezone Việt Nam
const VN_TZ = 'Asia/Ho_Chi_Minh';

// Virtual: created_at
ProductClickSchema.virtual('created_at').get(function (this: ProductClick) {
    if (!this.createdAt) return null;
    const zoned = toZonedTime(this.createdAt, VN_TZ);
    return format(zoned, 'HH:mm:ss dd-MM-yyyy');
});

// Virtual: updated_at
ProductClickSchema.virtual('updated_at').get(function (this: ProductClick) {
    if (!this.updatedAt) return null;
    const zoned = toZonedTime(this.updatedAt, VN_TZ);
    return format(zoned, 'HH:mm:ss dd-MM-yyyy');
});

// Xuất ra JSON kèm virtuals
ProductClickSchema.set('toJSON', { virtuals: true });
