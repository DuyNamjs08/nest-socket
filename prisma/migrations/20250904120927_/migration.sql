/*
  Warnings:

  - You are about to alter the column `status` on the `payments` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(0))` to `VarChar(20)`.
  - You are about to drop the column `orgin_price` on the `refunds` table. All the data in the column will be lost.
  - You are about to drop the `video_image_ai` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `video_image_ai` DROP FOREIGN KEY `video_image_ai_user_id_fkey`;

-- AlterTable
ALTER TABLE `payments` ADD COLUMN `customer_email` VARCHAR(100) NULL,
    ADD COLUMN `is_send_email` SMALLINT NULL DEFAULT 1,
    MODIFY `status` VARCHAR(20) NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE `products` ADD COLUMN `counts` INTEGER NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `refunds` DROP COLUMN `orgin_price`,
    ADD COLUMN `origin_price` INTEGER NULL DEFAULT 0,
    ADD COLUMN `response_json` TEXT NULL,
    ADD COLUMN `toss_description` TEXT NULL;

-- DropTable
DROP TABLE `video_image_ai`;

-- CreateTable
CREATE TABLE `send_email_payments` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `payment_id` BIGINT NOT NULL,
    `template_name` VARCHAR(45) NULL,
    `email_title` VARCHAR(255) NULL,
    `user_id` BIGINT NULL,
    `customer_name` VARCHAR(255) NULL,
    `customer_email` VARCHAR(255) NULL,
    `start_send_email` DATE NULL,
    `amount` DECIMAL(12, 2) NULL DEFAULT 0.00,
    `is_sent` TINYINT NULL DEFAULT 0,
    `status_send_email` VARCHAR(50) NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `idx_send_email_date`(`start_send_email`, `is_sent`),
    INDEX `idx_send_email_user`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `products_id_user_id_idx` ON `products`(`id`, `user_id`);
