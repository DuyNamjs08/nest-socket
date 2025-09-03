-- CreateTable
CREATE TABLE `video_image_ai` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `prompt` VARCHAR(191) NOT NULL,
    `url` JSON NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` DATETIME(0) NULL,

    INDEX `video_image_ai_user_id_idx`(`user_id`),
    INDEX `video_image_ai_status_idx`(`status`),
    INDEX `video_image_ai_created_at_idx`(`created_at`),
    INDEX `video_image_ai_user_id_status_idx`(`user_id`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `video_image_ai` ADD CONSTRAINT `video_image_ai_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
