-- CreateTable
CREATE TABLE `admin_notification` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NULL,
    `description` TEXT NULL,
    `country` VARCHAR(45) NULL,
    `status` TINYINT NULL DEFAULT 0,
    `url` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `icon` VARCHAR(255) NULL,
    `redirect_type` VARCHAR(255) NULL,
    `ask_again` TINYINT NULL,
    `repeat_duration` INTEGER NULL,
    `button_cancel` VARCHAR(50) NULL,
    `button_oke` VARCHAR(50) NULL,
    `popup_type` VARCHAR(45) NULL DEFAULT 'popup',
    `toasts_color` VARCHAR(45) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `batchs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `url` TEXT NULL,
    `shorten_link` VARCHAR(200) NULL,
    `thumbnail` VARCHAR(500) NULL,
    `thumbnails` LONGTEXT NULL,
    `content` LONGTEXT NULL,
    `type` TINYINT NOT NULL DEFAULT 1,
    `count_post` TINYINT NULL DEFAULT 0,
    `done_post` TINYINT NULL DEFAULT 0,
    `status` TINYINT NULL DEFAULT 1,
    `process_status` VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    `updated_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NULL,
    `voice_google` TINYINT NULL DEFAULT 1,
    `voice_typecast` VARCHAR(100) NULL DEFAULT '',
    `voice` VARCHAR(100) NULL DEFAULT '',
    `voice_type` VARCHAR(45) NULL,
    `is_advance` TINYINT NULL,
    `is_paid_advertisements` TINYINT NULL,
    `error_code` VARCHAR(45) NULL,
    `error_message` TEXT NULL,
    `message` TEXT NULL,
    `template_info` LONGTEXT NULL,
    `batch_total` INTEGER NULL DEFAULT 0,
    `batch_of_month` VARCHAR(50) NULL DEFAULT '',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `billing_cards` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `auth_key` VARCHAR(45) NULL,
    `user_id` BIGINT NULL,
    `customer_key` VARCHAR(255) NULL,
    `method` VARCHAR(255) NULL,
    `billing_key` VARCHAR(255) NULL,
    `card_company` VARCHAR(255) NULL,
    `card_number` VARCHAR(255) NULL,
    `issuer_code` VARCHAR(255) NULL,
    `acquirer_code` VARCHAR(255) NULL,
    `card_type` VARCHAR(255) NULL,
    `owner_type` VARCHAR(255) NULL,
    `is_default` SMALLINT NULL DEFAULT 0,
    `description` TEXT NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `captions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(500) NULL,
    `type_content` VARCHAR(45) NULL,
    `status` VARCHAR(45) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `description` LONGTEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chatgpt_results` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(50) NULL,
    `link_type` VARCHAR(50) NULL,
    `link` TEXT NULL,
    `item_id` VARCHAR(50) NULL,
    `vendor_id` VARCHAR(50) NULL,
    `name` TEXT NULL,
    `name_hash` VARCHAR(200) NULL,
    `response` LONGTEXT NULL,
    `status` TINYINT NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `chatgpt_results_type_index`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `coupon_codes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `coupon_id` INTEGER NULL,
    `code` VARCHAR(20) NOT NULL,
    `is_used` TINYINT NOT NULL DEFAULT 0,
    `is_active` TINYINT NULL DEFAULT 0,
    `used_at` DATETIME(0) NULL,
    `used_by` INTEGER NULL,
    `expired_at` DATETIME(0) NULL,
    `value` INTEGER NULL DEFAULT 30,
    `num_days` INTEGER NULL DEFAULT 30,
    `created_at` DATETIME(0) NULL,
    `updated_at` DATETIME(0) NULL,
    `total_link_active` INTEGER NULL DEFAULT 7,

    UNIQUE INDEX `code_UNIQUE`(`code`),
    INDEX `coupon_code_coupon_id_idx`(`coupon_id`),
    INDEX `coupon_code_used_by`(`used_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `coupon_user_histories` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `batch_id` INTEGER NULL,
    `old_batch_remain` VARCHAR(45) NULL,
    `new_batch_remain` VARCHAR(45) NULL,
    `total_link_active` INTEGER NULL DEFAULT 0,
    `type` VARCHAR(20) NULL,
    `type_2` VARCHAR(20) NULL,
    `object_id` INTEGER NULL DEFAULT 0,
    `title` VARCHAR(255) NULL,
    `description` LONGTEXT NULL,
    `value` INTEGER NULL,
    `admin_description` LONGTEXT NULL,
    `subscription` VARCHAR(45) NULL,
    `subscription_expired` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `coupons` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `image` VARCHAR(500) NULL,
    `name` VARCHAR(250) NOT NULL,
    `description` TEXT NULL,
    `expired_from` DATETIME(0) NULL,
    `expired` DATETIME(0) NULL,
    `type` VARCHAR(20) NULL DEFAULT 'DISCOUNT',
    `value` FLOAT NULL DEFAULT 0,
    `used` INTEGER NULL DEFAULT 0,
    `max_used` INTEGER NULL DEFAULT 0,
    `is_has_whitelist` TINYINT NULL DEFAULT 0,
    `white_lists` LONGTEXT NULL,
    `is_active` TINYINT NULL,
    `is_check_user` TINYINT NULL DEFAULT 0,
    `max_per_user` INTEGER NULL DEFAULT 0,
    `created_by` INTEGER NULL,
    `created_at` DATETIME(0) NULL,
    `updated_at` DATETIME(0) NULL,
    `plan_coupon` VARCHAR(45) NULL DEFAULT 'STANDARD',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `crawl_datas` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `site` VARCHAR(100) NOT NULL,
    `input_url` TEXT NOT NULL,
    `crawl_url` VARCHAR(500) NOT NULL,
    `crawl_url_hash` VARCHAR(100) NOT NULL,
    `request` TEXT NULL,
    `response` LONGTEXT NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `crawl_datas_crawl_url_hash_IDX`(`crawl_url_hash`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `groups_product` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `order_no` INTEGER NULL DEFAULT 0,
    `description` TEXT NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `title_type` VARCHAR(45) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `image_templates` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `template_name` VARCHAR(255) NULL DEFAULT '',
    `template_code` VARCHAR(50) NULL DEFAULT '',
    `template_image` VARCHAR(255) NULL DEFAULT '',
    `font` VARCHAR(255) NULL DEFAULT '',
    `font_name` VARCHAR(255) NULL DEFAULT '',
    `font_path` VARCHAR(255) NULL DEFAULT '',
    `font_size` INTEGER NULL DEFAULT 0,
    `main_text_color` VARCHAR(255) NULL DEFAULT 'random_color',
    `text_color` VARCHAR(255) NULL DEFAULT '#FFFFFF',
    `stroke_color` VARCHAR(255) NULL DEFAULT '#000000',
    `stroke_width` INTEGER NULL DEFAULT 5,
    `text_shadow` VARCHAR(255) NULL,
    `text_align` VARCHAR(255) NULL DEFAULT 'left',
    `text_position` VARCHAR(255) NULL DEFAULT 'center',
    `text_position_x` INTEGER NULL DEFAULT 0,
    `text_position_y` INTEGER NULL DEFAULT 0,
    `background` VARCHAR(255) NULL DEFAULT 'random_color',
    `background_color` VARCHAR(255) NULL DEFAULT '',
    `background_image` VARCHAR(255) NULL DEFAULT '',
    `padding` VARCHAR(255) NULL DEFAULT '',
    `margin` VARCHAR(255) NULL,
    `type` VARCHAR(50) NULL DEFAULT 'TEMPLATE_IMAGE_1',
    `other_font_path` VARCHAR(255) NULL,
    `other_font_size` INTEGER NULL DEFAULT 80,
    `other_text_color` VARCHAR(255) NULL DEFAULT '#FFFFFF',
    `other_margin` VARCHAR(255) NULL,
    `other_stroke_color` VARCHAR(255) NULL DEFAULT '#000000',
    `other_stroke_width` INTEGER NULL DEFAULT 5,
    `other_text_shadow` VARCHAR(255) NULL DEFAULT '',
    `other_text_align` VARCHAR(255) NULL DEFAULT 'left',
    `other_text_position` VARCHAR(255) NULL DEFAULT 'center',
    `is_create_first_image` TINYINT NULL DEFAULT 1,
    `is_blur` TINYINT NULL DEFAULT 0,
    `is_overlay_background` TINYINT NULL DEFAULT 0,
    `overlay_color` VARCHAR(45) NULL DEFAULT '#000000',
    `layout` VARCHAR(45) NULL DEFAULT 'center',
    `background_type` VARCHAR(45) NULL DEFAULT 'color',
    `logo_path` VARCHAR(255) NULL,
    `logo_size` VARCHAR(50) NULL DEFAULT '100,100',
    `logo_position` VARCHAR(50) NULL DEFAULT 'bottom_right',
    `created_by` INTEGER NULL DEFAULT 0,
    `sort` INTEGER NULL DEFAULT 0,
    `status` VARCHAR(50) NULL DEFAULT 'ACTIVE',
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `link_send_log` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `link_id` INTEGER NOT NULL,
    `post_id` INTEGER NOT NULL,
    `request_url` VARCHAR(500) NULL,
    `request` TEXT NULL,
    `response` TEXT NULL,
    `status` INTEGER NOT NULL DEFAULT 1,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `link_send_log_link_id`(`link_id`),
    INDEX `link_send_log_post_id`(`post_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `links` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `avatar` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `need_info` TEXT NULL,
    `type` VARCHAR(50) NOT NULL DEFAULT 'FACEBOOK',
    `social_type` VARCHAR(50) NULL DEFAULT 'SOCIAL',
    `status` TINYINT NULL DEFAULT 1,
    `updated_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `member_profiles` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `nick_name` VARCHAR(500) NULL DEFAULT '',
    `member_name` VARCHAR(500) NULL DEFAULT '',
    `member_avatar` VARCHAR(500) NULL DEFAULT '',
    `member_background` VARCHAR(500) NULL,
    `member_address` TEXT NULL,
    `design_settings` TEXT NULL,
    `content` TEXT NULL,
    `description` TEXT NULL,
    `status` INTEGER NULL DEFAULT 1,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `social_is_thread` INTEGER NULL DEFAULT 0,
    `social_thread_url` VARCHAR(500) NULL,
    `social_is_youtube` INTEGER NULL,
    `social_youtube_url` VARCHAR(500) NULL,
    `social_is_x` INTEGER NULL,
    `social_x_url` VARCHAR(500) NULL,
    `social_is_instagram` INTEGER NULL,
    `social_instagram_url` VARCHAR(500) NULL,
    `social_is_tiktok` INTEGER NULL,
    `social_tiktok_url` VARCHAR(500) NULL,
    `social_is_facebook` INTEGER NULL,
    `social_facebook_url` VARCHAR(500) NULL,
    `social_is_spotify` INTEGER NULL,
    `social_spotify_url` VARCHAR(500) NULL,
    `guide_info` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `month_texts` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `keyword` VARCHAR(255) NULL DEFAULT '',
    `hashtag` VARCHAR(255) NULL DEFAULT '',
    `month` VARCHAR(50) NOT NULL DEFAULT '',
    `status` VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `month_texts_month`(`month`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notifications` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `notification_type` VARCHAR(50) NULL DEFAULT 'video',
    `user_id` INTEGER NULL,
    `batch_id` INTEGER NULL,
    `post_id` INTEGER NULL,
    `thumbnail` VARCHAR(500) NULL,
    `images` TEXT NULL,
    `captions` TEXT NULL,
    `title` VARCHAR(2048) NULL,
    `description` TEXT NULL,
    `hooking` TEXT NULL,
    `content` TEXT NULL,
    `video_url` VARCHAR(255) NULL,
    `hashtag` TEXT NULL,
    `status` TINYINT NULL DEFAULT 1,
    `render_id` VARCHAR(45) NULL,
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `social_sns_description` LONGTEXT NULL,
    `status_sns` INTEGER NULL DEFAULT 0,
    `is_read` INTEGER NULL DEFAULT 0,
    `send_telegram` INTEGER NULL DEFAULT 0,
    `description_korea` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ocr_results` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `image_url` TEXT NULL,
    `image_hash` VARCHAR(200) NULL,
    `response` LONGTEXT NULL,
    `status` TINYINT NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `ocr_results_image_hash_index`(`image_hash`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment_details` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `payment_id` INTEGER NULL,
    `amount` INTEGER NULL DEFAULT 0,
    `price` INTEGER NULL DEFAULT 0,
    `description` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment_logs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `payment_id` INTEGER NULL,
    `raw_response` TEXT NULL,
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `status_code` VARCHAR(45) NULL,
    `response_json` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `description` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER NULL,
    `package_name` VARCHAR(50) NULL,
    `user_id` INTEGER NULL,
    `order_id` VARCHAR(255) NULL,
    `payment_key` VARCHAR(255) NULL,
    `customer_name` VARCHAR(100) NULL,
    `amount` INTEGER NULL DEFAULT 0,
    `price` INTEGER NULL DEFAULT 0,
    `total_link` INTEGER NULL DEFAULT 0,
    `total_create` INTEGER NULL DEFAULT 0,
    `method` VARCHAR(50) NULL,
    `requested_at` DATETIME(0) NULL,
    `start_date` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `end_date` TIMESTAMP(0) NULL,
    `status` ENUM('PENDING', 'PAID', 'FAILED') NULL DEFAULT 'PENDING',
    `approved_at` DATETIME(0) NULL,
    `fail_reason` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `payment_method` VARCHAR(50) NULL,
    `payment_status` VARCHAR(50) NULL,
    `payment_date` TIMESTAMP(0) NULL,
    `payment_data` LONGTEXT NULL,
    `description` LONGTEXT NULL,
    `is_renew` INTEGER NULL DEFAULT 0,
    `next_payment` INTEGER NULL DEFAULT 0,
    `next_total_link` INTEGER NULL,
    `used_created` INTEGER NULL DEFAULT 0,
    `order_type` INTEGER NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `posts` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(10) NULL DEFAULT 'video',
    `user_id` INTEGER NULL,
    `batch_id` INTEGER NULL,
    `thumbnail` VARCHAR(500) NULL,
    `images` TEXT NULL,
    `captions` TEXT NULL,
    `title` VARCHAR(500) NULL,
    `description` TEXT NULL,
    `hooking` TEXT NULL,
    `content` LONGTEXT NULL,
    `video_url` VARCHAR(255) NULL,
    `docx_url` VARCHAR(255) NULL,
    `hashtag` TEXT NULL,
    `status` TINYINT NULL DEFAULT 1,
    `render_id` VARCHAR(45) NULL,
    `mime_type` VARCHAR(250) NULL DEFAULT '',
    `file_size` VARCHAR(45) NULL DEFAULT '',
    `process_number` INTEGER NULL DEFAULT 0,
    `subtitle` VARCHAR(500) NULL,
    `updated_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NULL,
    `social_sns_description` LONGTEXT NULL,
    `status_sns` INTEGER NULL DEFAULT 0,
    `process_status` VARCHAR(45) NULL DEFAULT 'PENDING',
    `error_message` TEXT NULL,
    `video_path` VARCHAR(255) NULL,
    `schedule_date` DATETIME(6) NULL,
    `images_s3` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `group_id` INTEGER NULL DEFAULT 0,
    `user_id` INTEGER NULL,
    `product_url` TEXT NULL,
    `product_url_hash` VARCHAR(500) NULL DEFAULT '',
    `shorten_link` VARCHAR(500) NULL,
    `product_name` VARCHAR(1024) NULL DEFAULT '',
    `product_image` VARCHAR(1024) NULL,
    `price` VARCHAR(20) NULL,
    `content` LONGTEXT NULL,
    `description` LONGTEXT NULL,
    `status` INTEGER NULL DEFAULT 1,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `order_no` INTEGER NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `referral_history` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `referrer_user_id` INTEGER NULL,
    `referred_user_id` INTEGER NULL,
    `referral_code` VARCHAR(45) NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `expired_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `status` VARCHAR(45) NULL DEFAULT 'PENDING',
    `days` INTEGER NULL DEFAULT 7,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `refunds` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `payment_id` BIGINT NULL,
    `user_id` BIGINT NULL,
    `amount` INTEGER NULL,
    `orgin_price` INTEGER NULL DEFAULT 0,
    `reason` TEXT NULL,
    `status` TINYINT NULL DEFAULT 0,
    `admin_note` TEXT NULL,
    `package_name` VARCHAR(255) NULL,
    `customer_name` VARCHAR(255) NULL,
    `type_payment` VARCHAR(45) NULL,
    `requested_at` DATETIME(0) NULL,
    `processed_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `request_logs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `post_id` VARCHAR(200) NOT NULL,
    `ai_type` VARCHAR(10) NOT NULL,
    `request` LONGTEXT NULL,
    `response` LONGTEXT NULL,
    `prompt_tokens` INTEGER NOT NULL DEFAULT 0,
    `prompt_cache_tokens` INTEGER NOT NULL DEFAULT 0,
    `prompt_audio_tokens` INTEGER NOT NULL DEFAULT 0,
    `completion_tokens` INTEGER NOT NULL DEFAULT 0,
    `completion_reasoning_tokens` INTEGER NOT NULL DEFAULT 0,
    `completion_audio_tokens` INTEGER NOT NULL DEFAULT 0,
    `completion_accepted_prediction_tokens` INTEGER NOT NULL DEFAULT 0,
    `completion_rejected_prediction_tokens` INTEGER NOT NULL DEFAULT 0,
    `total_tokens` INTEGER NOT NULL DEFAULT 0,
    `status` TINYINT NOT NULL DEFAULT 1,
    `updated_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NULL,

    INDEX `request_logs_ai_type_idx`(`ai_type`),
    INDEX `request_logs_post_id_idx`(`post_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `request_social_counts` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `social` VARCHAR(50) NOT NULL,
    `user_id` INTEGER NULL DEFAULT 0,
    `count` INTEGER NULL DEFAULT 0,
    `day` VARCHAR(50) NOT NULL DEFAULT '',
    `hour` VARCHAR(50) NOT NULL DEFAULT '',
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `request_social_logs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `social` VARCHAR(50) NULL,
    `user_id` INTEGER NOT NULL,
    `type` VARCHAR(50) NULL,
    `social_post_id` INTEGER NULL DEFAULT 0,
    `request` TEXT NULL,
    `response` LONGTEXT NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `request_social_logs_social`(`social`),
    INDEX `request_social_logs_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `schedules` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `video_id` INTEGER NULL,
    `date` DATE NULL,
    `title` VARCHAR(255) NULL,
    `status` TINYINT NULL DEFAULT 1,
    `updated_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `setting` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `setting_name` VARCHAR(45) NULL,
    `setting_value` VARCHAR(500) NULL,
    `status` INTEGER NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shorten_url` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `original_url` VARCHAR(2048) NULL,
    `original_url_hash` VARCHAR(100) NULL,
    `short_code` VARCHAR(45) NULL,
    `status` VARCHAR(45) NULL,
    `count` INTEGER NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `shorten_url_code`(`short_code`),
    INDEX `shorten_url_original_url_hash`(`original_url_hash`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `social_accounts` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `provider` VARCHAR(50) NOT NULL,
    `provider_user_id` VARCHAR(100) NOT NULL,
    `access_token` TEXT NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `social_account_provider`(`provider`),
    INDEX `social_account_provider_provider_user_id`(`provider`, `provider_user_id`),
    INDEX `social_account_user_id_provider`(`user_id`, `provider`),
    INDEX `social_accounts_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `social_post_created` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `social` VARCHAR(50) NOT NULL,
    `user_id` INTEGER NULL DEFAULT 0,
    `count` INTEGER NULL DEFAULT 0,
    `day` VARCHAR(50) NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `social_posts` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `link_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,
    `batch_id` INTEGER NULL,
    `post_id` INTEGER NOT NULL,
    `sync_id` INTEGER NULL DEFAULT 0,
    `session_key` VARCHAR(100) NULL,
    `social_link` VARCHAR(700) NULL,
    `status` VARCHAR(50) NULL DEFAULT 'PUBLISHED',
    `error_message` LONGTEXT NULL,
    `show_message` LONGTEXT NULL,
    `process_number` INTEGER NULL DEFAULT 0,
    `disable_comment` TINYINT NULL DEFAULT 0,
    `auto_add_music` TINYINT NULL DEFAULT 0,
    `privacy_level` VARCHAR(50) NULL DEFAULT 'SELF_ONLY',
    `disable_duet` TINYINT NULL DEFAULT 0,
    `disable_stitch` TINYINT NULL,
    `instagram_quote` LONGTEXT NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    INDEX `social_posts_link_id`(`link_id`),
    INDEX `social_posts_post_id`(`post_id`),
    INDEX `social_posts_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `social_syncs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL DEFAULT 0,
    `in_post_ids` TEXT NULL,
    `post_ids` TEXT NULL,
    `social_post_ids` TEXT NULL,
    `status` VARCHAR(50) NULL DEFAULT '',
    `process_number` INTEGER NULL DEFAULT 0,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tiktok_callback` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `code` TEXT NULL,
    `state` TEXT NULL,
    `response` TEXT NULL,
    `error` TEXT NULL,
    `error_description` TEXT NULL,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_histories` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `used_created` INTEGER NULL DEFAULT 0,
    `order_type` SMALLINT NULL DEFAULT 0,
    `expire_checked` SMALLINT NULL DEFAULT 0,
    `expire_checked_at` TIMESTAMP(0) NULL,
    `type` VARCHAR(20) NULL,
    `type_2` VARCHAR(20) NULL,
    `object_id` INTEGER NULL DEFAULT 0,
    `object_start_time` DATETIME(0) NULL,
    `object_end_time` DATETIME(0) NULL,
    `title` VARCHAR(255) NULL,
    `description` LONGTEXT NULL,
    `value` INTEGER NULL,
    `num_days` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `admin_description` LONGTEXT NULL,
    `total_link_active` INTEGER NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_links` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `link_id` INTEGER NOT NULL,
    `social_id` VARCHAR(150) NULL,
    `username` VARCHAR(150) NULL,
    `name` VARCHAR(500) NULL,
    `avatar` VARCHAR(1024) NULL,
    `url` VARCHAR(1024) NULL,
    `meta` TEXT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `youtube_client` TEXT NULL,
    `warning` TINYINT NULL DEFAULT 0,
    `expired_date` DATE NULL,
    `expired_at` DATETIME(0) NULL,
    `updated_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NULL,
    `meta_url` VARCHAR(1024) NULL,
    `page_id` VARCHAR(255) NULL,

    INDEX `user_link_expired_date`(`expired_date`),
    INDEX `user_link_link_id_idx`(`link_id`),
    INDEX `user_link_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_video_templates` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL DEFAULT 0,
    `is_paid_advertisements` TINYINT NULL DEFAULT 0,
    `product_name` VARCHAR(500) NULL DEFAULT '',
    `is_caption_top` TINYINT NULL DEFAULT 0,
    `is_product_name` TINYINT NULL DEFAULT 0,
    `purchase_guide` VARCHAR(500) NULL DEFAULT '',
    `is_purchase_guide` TINYINT NULL DEFAULT 0,
    `voice_gender` TINYINT NULL DEFAULT 0,
    `voice_id` TINYINT NULL DEFAULT 0,
    `is_video_hooking` TINYINT NULL DEFAULT 0,
    `is_caption_last` TINYINT NULL DEFAULT 0,
    `image_template_id` VARCHAR(500) NULL DEFAULT '1',
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `image_template` TEXT NULL,
    `video_hooks` TEXT NULL,
    `viral_messages` TEXT NULL,
    `subscribe_video` TEXT NULL,
    `narration` VARCHAR(45) NULL DEFAULT 'male',
    `link_sns` TEXT NULL,
    `comment` VARCHAR(255) NULL,
    `hashtag` TEXT NULL,
    `is_comment` TINYINT NULL DEFAULT 0,
    `is_hashtag` TINYINT NULL DEFAULT 0,
    `is_product_description` TINYINT NULL,
    `product_description` VARCHAR(500) NULL,
    `is_product_pin` TINYINT NULL,
    `product_pin` VARCHAR(500) NULL,
    `typecast_voice` VARCHAR(100) NULL,
    `voice` VARCHAR(100) NULL DEFAULT '',
    `voice_type` VARCHAR(45) NULL DEFAULT 'google',
    `is_advance` TINYINT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `subscription` VARCHAR(100) NULL DEFAULT 'FREE',
    `subscription_expired` DATETIME(0) NULL,
    `username` VARCHAR(50) NULL,
    `name` VARCHAR(255) NULL,
    `avatar` VARCHAR(500) NULL,
    `email` VARCHAR(150) NULL,
    `password` VARCHAR(100) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` DATETIME(0) NULL,
    `auth_token_youtube` VARCHAR(255) NULL,
    `auth_token_facebook` VARCHAR(255) NULL,
    `auth_token_tiktok` VARCHAR(255) NULL,
    `auth_token_x` VARCHAR(255) NULL,
    `auth_token_instagram` VARCHAR(255) NULL,
    `auth_token_threads` VARCHAR(255) NULL,
    `last_activated` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `phone` VARCHAR(255) NULL,
    `contact` VARCHAR(255) NULL,
    `company_name` VARCHAR(255) NULL,
    `level` TINYINT NULL DEFAULT 0,
    `level_info` TEXT NULL,
    `user_type` TINYINT NULL DEFAULT 0,
    `batch_total` INTEGER NULL DEFAULT 10,
    `batch_remain` INTEGER NULL DEFAULT 10,
    `batch_of_month` VARCHAR(50) NULL DEFAULT '',
    `ali_express_info` TEXT NULL,
    `ali_express_active` TINYINT NULL DEFAULT 0,
    `batch_sns_total` INTEGER NULL DEFAULT 0,
    `batch_sns_remain` INTEGER NULL DEFAULT 0,
    `batch_no_limit_sns` TINYINT NULL DEFAULT 0,
    `is_auth_nice` TINYINT NULL DEFAULT 0,
    `is_verify_email` TINYINT NULL DEFAULT 0,
    `auth_nice_result` TEXT NULL,
    `gender` VARCHAR(255) NULL,
    `password_certificate` VARCHAR(255) NULL,
    `referral_code` VARCHAR(45) NULL,
    `total_link_active` INTEGER NULL DEFAULT 0,
    `referrer_user_id` INTEGER NULL DEFAULT 0,
    `customerKey` VARCHAR(45) NULL,
    `card_info` TEXT NULL,
    `is_auto_payment` INTEGER NULL DEFAULT 0,

    INDEX `email`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `video_create` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `post_id` VARCHAR(200) NULL,
    `render_id` VARCHAR(45) NULL,
    `user_id` INTEGER NULL,
    `product_name` VARCHAR(500) NULL,
    `images_url` TEXT NULL,
    `status` VARCHAR(45) NULL DEFAULT 'queued',
    `hash_tags` VARCHAR(500) NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `video_url` VARCHAR(500) NULL,
    `google_driver_url` VARCHAR(500) NULL,
    `captions` TEXT NULL,
    `origin_caption` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `video_viral` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `category_id` INTEGER NULL DEFAULT 0,
    `video_name` VARCHAR(500) NULL,
    `video_url` VARCHAR(500) NULL,
    `status` INTEGER NULL,
    `duration` FLOAT NULL DEFAULT 0,
    `description` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `type` VARCHAR(45) NULL DEFAULT 'video',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `voices` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `string_id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `name_en` VARCHAR(255) NOT NULL,
    `name_google` VARCHAR(255) NULL DEFAULT '',
    `gender` VARCHAR(10) NOT NULL,
    `image_url` VARCHAR(1024) NULL,
    `audio_url` VARCHAR(1024) NOT NULL,
    `type` VARCHAR(20) NOT NULL,
    `styles` TEXT NULL,
    `volumn` FLOAT NOT NULL,
    `speed_x` FLOAT NOT NULL,
    `tempo` FLOAT NOT NULL,
    `emotion_tone_preset` VARCHAR(255) NOT NULL,
    `model_version` VARCHAR(255) NOT NULL,
    `xapi_audio_format` VARCHAR(255) NOT NULL,
    `xapi_hd` BOOLEAN NOT NULL,
    `order` TINYINT NULL DEFAULT 0,
    `created_at` DATETIME(0) NULL,
    `updated_at` DATETIME(0) NULL,

    INDEX `ix_voices_string_id`(`string_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `youtube_clients` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_ids` LONGTEXT NOT NULL,
    `member_count` INTEGER NULL DEFAULT 0,
    `project_name` VARCHAR(100) NULL,
    `client_id` VARCHAR(150) NOT NULL,
    `client_secret` VARCHAR(150) NOT NULL,
    `status` TINYINT NULL DEFAULT 1,
    `updated_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `coupon_codes` ADD CONSTRAINT `coupon_code_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `social_accounts` ADD CONSTRAINT `social_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_links` ADD CONSTRAINT `user_link_link_id` FOREIGN KEY (`link_id`) REFERENCES `links`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_links` ADD CONSTRAINT `user_link_user_id` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
