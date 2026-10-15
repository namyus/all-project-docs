DROP DATABASE IF EXISTS wdcrbp;
CREATE DATABASE wdcrbp;
USE wdcrbp;

create table category
(
    category_id    bigint auto_increment
        primary key,
    category_level varchar(255) null,
    category_name  varchar(255) null,
    created_at     datetime(6)  null,
    description    varchar(255) null,
    parent_id      bigint       null,
    status         bit          null,
    updated_at     datetime(6)  null
);

create table configuration
(
    configuration_id bigint auto_increment
        primary key,
    created_by       datetime(6)   null,
    description      varchar(255)  null,
    name             varchar(255)  null,
    updated_at       datetime(6)   null,
    value            varchar(2000) null
);

create table consultant_appointment
(
    appointment_id bigint auto_increment
        primary key,
    content        varchar(2000) null,
    created_at     datetime(6)   null,
    date_time      datetime(6)   null,
    form           varchar(255)  null,
    meet_address   varchar(2000) null,
    status         bit           null
);

create table refresh_tokens
(
    id      int auto_increment
        primary key,
    expired bit          not null,
    revoked bit          not null,
    token   varchar(255) null
);

create table service
(
    service_id         bigint auto_increment
        primary key,
    created_at         datetime(6)  null,
    number_of_deposits smallint     null,
    service_name       varchar(255) null,
    status             bit          null,
    updated_at         datetime(6)  null
);

create table service_deposit
(
    service_deposit_id bigint auto_increment
        primary key,
    created_at         datetime(6)  null,
    deposit_number     smallint     null,
    description        varchar(255) null,
    percent            smallint     null,
    status             bit          null,
    updated_at         datetime(6)  null,
    service_id         bigint       null,
    constraint FKsn4o3ub691su8i8svfmqevpsw
        foreign key (service_id) references service (service_id)
);

create table service_pack
(
    service_pack_id        bigint auto_increment
        primary key,
    description            varchar(255) null,
    duration               smallint     null,
    name                   varchar(255) null,
    personalization        bit          null,
    post_limit_per_month   smallint     null,
    price                  float        null,
    product_management     bit          null,
    search_result_priority smallint     null,
    status                 bit          null
);

create table tech_spec
(
    tech_spec_id bigint auto_increment
        primary key,
    created_at   datetime(6)  null,
    name         varchar(255) not null,
    option_type  varchar(255) null,
    status       bit          null,
    updated_at   datetime(6)  null
);

create table tech_spec_value
(
    tech_spec_value_id bigint auto_increment
        primary key,
    value              varchar(255) null,
    tech_spec_id       bigint       not null,
    constraint FK697yskau887d0bruo81ekx0j3
        foreign key (tech_spec_id) references tech_spec (tech_spec_id)
);

create table user
(
    user_id    bigint auto_increment
        primary key,
    otp        varchar(255) null,
    created_at datetime(6)  null,
    email      varchar(255) null,
    password   varchar(255) null,
    phone      varchar(255) null,
    role       varchar(255) null,
    status     bit          null,
    username   varchar(255) null
);

create table access_tokens
(
    id               int auto_increment
        primary key,
    expired          bit          not null,
    revoked          bit          not null,
    token            varchar(255) null,
    refresh_token_id int          null,
    user_id          bigint       null,
    constraint FK1mdrmt28js30f5lysnn3w5k5d
        foreign key (user_id) references user (user_id),
    constraint FKokixsyunu9wsrv5ab5e1ilyrk
        foreign key (refresh_token_id) references refresh_tokens (id)
);

create table review
(
    review_id                  bigint auto_increment
        primary key,
    comment                    varchar(255) null,
    created_at                 datetime(6)  null,
    rating                     int          null,
    response_at                datetime(6)  null,
    status                     bit          null,
    updated_at                 datetime(6)  null,
    woodworker_response        varchar(255) null,
    woodworker_response_status bit          null,
    user_id                    bigint       not null,
    constraint FKiyf57dy48lyiftdrf7y87rnxi
        foreign key (user_id) references user (user_id)
);

create table user_address
(
    user_address_id bigint auto_increment
        primary key,
    address         varchar(255) null,
    city_id         varchar(255) null,
    created_at      datetime(6)  null,
    district_id     varchar(255) null,
    is_default      bit          null,
    ward_code       varchar(255) null,
    user_id         bigint       null,
    constraint FKk2ox3w9jm7yd6v1m5f68xibry
        foreign key (user_id) references user (user_id)
);

create table wallet
(
    wallet_id  bigint auto_increment
        primary key,
    balance    float       null,
    created_at datetime(6) null,
    updated_at datetime(6) null,
    user_id    bigint      null,
    constraint UKhgee4p1hiwadqinr0avxlq4eb
        unique (user_id),
    constraint FKbs4ogwiknsup4rpw8d47qw9dx
        foreign key (user_id) references user (user_id)
);

create table woodworker_profile
(
    woodworker_id           bigint auto_increment
        primary key,
    address                 varchar(255)  null,
    bio                     varchar(2000) null,
    brand_name              varchar(255)  null,
    business_type           varchar(255)  null,
    city_id                 varchar(255)  null,
    created_at              datetime(6)   null,
    district_id             varchar(255)  null,
    img_url                 varchar(2000) null,
    no_order                varchar(255)  null,
    public_status           bit           null,
    rating                  int           null,
    service_pack_end_date   datetime(6)   null,
    service_pack_start_date datetime(6)   null,
    status                  bit           null,
    tax_code                varchar(255)  null,
    total_reviews           smallint      null,
    total_star              smallint      null,
    updated_at              datetime(6)   null,
    verification_stauts     varchar(255)  null,
    ward_code               varchar(255)  null,
    warranty_policy         varchar(2000) null,
    service_pack_id         bigint        null,
    user_id                 bigint        null,
    constraint UKasft1kf05pexu0t2rhyig20xc
        unique (user_id),
    constraint FKl9kepu1wbpvqx71uw5ef2x4rv
        foreign key (service_pack_id) references service_pack (service_pack_id),
    constraint FKsx1054xm5dc592xmcrys7b5w3
        foreign key (user_id) references user (user_id)
);

create table available_service
(
    available_service_id bigint auto_increment
        primary key,
    created_at           datetime(6)   null,
    description          varchar(2000) null,
    operating_status     bit           null,
    status               bit           null,
    updated_at           datetime(6)   null,
    service_id           bigint        null,
    woodworker_id        bigint        null,
    constraint FK4u20n4xe1wbuparw8ewww2c0s
        foreign key (woodworker_id) references woodworker_profile (woodworker_id),
    constraint FKemydguksw8x96aph1oy8gikd2
        foreign key (service_id) references service (service_id)
);

create table design_idea
(
    design_idea_id bigint auto_increment
        primary key,
    description    varchar(2000) null,
    img_urls       varchar(2000) null,
    is_install     bit           null,
    name           varchar(255)  null,
    total_reviews  smallint      null,
    total_star     smallint      null,
    category_id    bigint        null,
    woodworker_id  bigint        null,
    constraint FKdk5vssex0oad7y4eotwvjj5cs
        foreign key (category_id) references category (category_id),
    constraint FKk7a9jn16hp4wi56ljutgmr1f3
        foreign key (woodworker_id) references woodworker_profile (woodworker_id)
);

create table design_idea_config
(
    design_idea_config_id bigint auto_increment
        primary key,
    description           varchar(255) null,
    specifications        varchar(255) null,
    updated_at            datetime(6)  null,
    design_idea_id        bigint       null,
    constraint FKf8cf5jjygad7cymnjfh8j23h5
        foreign key (design_idea_id) references design_idea (design_idea_id)
);

create table design_idea_config_value
(
    design_idea_config_value_id bigint auto_increment
        primary key,
    updated_at                  datetime(6)  null,
    value                       varchar(255) null,
    design_idea_config_id       bigint       null,
    constraint FKoacljemm6w228r3vrtykoodma
        foreign key (design_idea_config_id) references design_idea_config (design_idea_config_id)
);

create table design_idea_variant
(
    design_idea_variant_id bigint auto_increment
        primary key,
    price                  float  null,
    design_idea_id         bigint null,
    constraint FKsneveqy0xw5di3l76p3ax6lw7
        foreign key (design_idea_id) references design_idea (design_idea_id)
);

create table design_idea_variant_config
(
    design_idea_variant_config_id bigint auto_increment
        primary key,
    updated_at                    datetime(6) null,
    design_idea_config_value_id   bigint      null,
    design_idea_variant_id        bigint      null,
    constraint FK27m87u12fn1py480iqc17nm4
        foreign key (design_idea_config_value_id) references design_idea_config_value (design_idea_config_value_id),
    constraint FK7ydjn5e6um4a79632cwbuxa5n
        foreign key (design_idea_variant_id) references design_idea_variant (design_idea_variant_id)
);

create table post
(
    post_id       bigint auto_increment
        primary key,
    created_at    datetime(6)   null,
    description   varchar(2000) null,
    img_urls      varchar(2000) null,
    title         varchar(255)  null,
    woodworker_id bigint        null,
    constraint FK7vksu1507rquqj09ypsyelh8t
        foreign key (woodworker_id) references woodworker_profile (woodworker_id)
);

create table product
(
    product_id        bigint auto_increment
        primary key,
    color             varchar(255)  null,
    description       varchar(2000) null,
    height            smallint      null,
    is_install        bit           null,
    length            smallint      null,
    media_urls        varchar(2000) null,
    price             float         null,
    product_name      varchar(255)  null,
    scent             varchar(255)  null,
    sculpture         varchar(255)  null,
    special_feature   varchar(255)  null,
    status            bit           null,
    stock             smallint      null,
    style             varchar(255)  null,
    total_reviews     smallint      null,
    total_star        smallint      null,
    warranty_duration smallint      null,
    width             smallint      null,
    wood_type         varchar(255)  null,
    category_id       bigint        null,
    woodworker_id     bigint        null,
    constraint FK1mtsbur82frn64de7balymq9s
        foreign key (category_id) references category (category_id),
    constraint FK7kgrlb4qj47uquv4838jpq6sd
        foreign key (woodworker_id) references woodworker_profile (woodworker_id)
);

create table service_order
(
    order_id             bigint auto_increment
        primary key,
    amount_paid          float        null,
    amount_remaining     float        null,
    created_at           datetime(6)  null,
    description          varchar(255) null,
    feedback             varchar(255) null,
    is_install           bit          null,
    quantity             smallint     null,
    role                 varchar(255) null,
    ship_fee             float        null,
    status               varchar(255) null,
    total_amount         float        null,
    updated_at           datetime(6)  null,
    available_service_id bigint       null,
    appointment_id       bigint       null,
    review_id            bigint       null,
    user_id              bigint       null,
    constraint UK4yq7mqfa3wa50omqrw0x84cnc
        unique (appointment_id),
    constraint UKg45yr34xjuuffdmjjbv6nhsyc
        unique (review_id),
    constraint FK2xqio6vucus1d2g8fpl837vq3
        foreign key (available_service_id) references available_service (available_service_id),
    constraint FK9ffldux6ul1donxpaiq95twuf
        foreign key (review_id) references review (review_id),
    constraint FKbwfew8r5wt5fqxc299ldxnfbh
        foreign key (appointment_id) references consultant_appointment (appointment_id),
    constraint FKn7rds5edqd2maagkf1c4jss3s
        foreign key (user_id) references user (user_id)
);

create table contract
(
    contract_id           bigint auto_increment
        primary key,
    agreement             varchar(2000)  null,
    complete_date         datetime(6)   null,
    contract_total_amount float         null,
    created_at            datetime(6)   null,
    cus_address           varchar(255)  null,
    cus_full_name         varchar(255)  null,
    cus_phone             varchar(255)  null,
    customer_signature    varchar(2000) null,
    sign_date             datetime(6)   null,
    woodworker_signature  varchar(2000) null,
    woodworker_terms      varchar(2000) null,
    order_id              bigint        null,
    constraint UKshiwfpv0nv8w65mum57wcuck5
        unique (order_id),
    constraint FKf0tw7wdy7roamq0w5vfcadvu5
        foreign key (order_id) references service_order (order_id)
);

create table requested_product
(
    requested_product_id   bigint auto_increment
        primary key,
    created_at             datetime(6) null,
    quantity               tinyint     null,
    total_amount           float       null,
    warranty_duration      smallint    null,
    category_id            bigint      null,
    design_idea_variant_id bigint      null,
    product_id             bigint      null,
    order_id               bigint      null,
    constraint FK26rlg4e4x27g24qhskp109mmb
        foreign key (design_idea_variant_id) references design_idea_variant (design_idea_variant_id),
    constraint FKittnwyuddw4ywxt7iu6nmnmp9
        foreign key (category_id) references category (category_id),
    constraint FKqsc66vahgom8opxueuebnirv5
        foreign key (order_id) references service_order (order_id),
    constraint FKsw2fgwaucq4k0105u4fy8irc4
        foreign key (product_id) references product (product_id)
);

create table customer_selection
(
    customer_selection_id bigint auto_increment
        primary key,
    created_at            datetime(6)  null,
    value                 varchar(255) null,
    requested_product_id  bigint       not null,
    tech_spec_id          bigint       not null,
    constraint FK7po1af8lns4vdjqv83uiw6mx3
        foreign key (requested_product_id) references requested_product (requested_product_id),
    constraint FKepf514flq43wg8iaokvvb2957
        foreign key (tech_spec_id) references tech_spec (tech_spec_id)
);

create table guarantee_order
(
    guarantee_order_id       bigint auto_increment
        primary key,
    amount_paid              float         null,
    amount_remaining         float         null,
    created_at               datetime(6)   null,
    current_product_img_urls varchar(2000) null,
    description              varchar(2000) null,
    feedback                 varchar(255)  null,
    guarantee_error          varchar(255)  null,
    is_guarantee             bit           null,
    is_install               bit           null,
    product_current_status   varchar(255)  null,
    role                     varchar(255)  null,
    ship_fee                 float         null,
    status                   varchar(255)  null,
    total_amount             float         null,
    updated_at               datetime(6)   null,
    available_service_id     bigint        null,
    appointment_id           bigint        null,
    requested_product_id     bigint        null,
    review_id                bigint        null,
    user_id                  bigint        null,
    constraint UK904syqa1up2mahk552tl1gxef
        unique (appointment_id),
    constraint UKk2s4v3ilpxtolw2ls634vl85f
        unique (review_id),
    constraint FK1hm8e8nknv5gx1m6cpfr34470
        foreign key (available_service_id) references available_service (available_service_id),
    constraint FKar562d48bd5trdv0s7net6i8t
        foreign key (requested_product_id) references requested_product (requested_product_id),
    constraint FKksx32l0nuni1oh31ecsa9364p
        foreign key (user_id) references user (user_id),
    constraint FKrikbotxscq3hmuh9u3ubb7pxp
        foreign key (appointment_id) references consultant_appointment (appointment_id),
    constraint FKsj0vw2uo3cngvh51f9wusstdn
        foreign key (review_id) references review (review_id)
);

create table order_deposit
(
    order_deposit_id   bigint auto_increment
        primary key,
    amount             float       null,
    created_at         datetime(6) null,
    deposit_number     smallint    null,
    percent            smallint    null,
    status             bit         null,
    updated_at         datetime(6) null,
    guarantee_order_id bigint      null,
    order_id           bigint      null,
    constraint FKq3qob24oormid31j6a9ku28ud
        foreign key (order_id) references service_order (order_id),
    constraint FKs9h6kiqqs5a1fvfilcog9io2a
        foreign key (guarantee_order_id) references guarantee_order (guarantee_order_id)
);

create table product_images
(
    product_images_id    bigint auto_increment
        primary key,
    media_urls           varchar(2000) null,
    type                 varchar(255)  null,
    requested_product_id bigint        not null,
    constraint FK4wdanhptppc78qrpes8p88ofq
        foreign key (requested_product_id) references requested_product (requested_product_id)
);

create table progress
(
    progress_id        bigint auto_increment
        primary key,
    created_by         bigint       null,
    created_time       datetime(6)  null,
    deleted_by         bigint       null,
    deleted_time       datetime(6)  null,
    description        varchar(255) null,
    status             varchar(255) null,
    guarantee_order_id bigint       null,
    order_id           bigint       null,
    constraint FK61itd0d2ylmk0msbsbhxpw29d
        foreign key (order_id) references service_order (order_id),
    constraint FKkegi11id6hcim5exv560f80f2
        foreign key (guarantee_order_id) references guarantee_order (guarantee_order_id)
);

create table quotation_detail
(
    quotation_detail_id  bigint auto_increment
        primary key,
    cost_amount          float        null,
    cost_type            varchar(255) null,
    quantity_required    varchar(255) null,
    guarantee_order_id   bigint       null,
    requested_product_id bigint       null,
    constraint FKfw2ne5y51kt263fve1ay9yup6
        foreign key (guarantee_order_id) references guarantee_order (guarantee_order_id),
    constraint FKg22jtprg10j1gty9vlqul9f1w
        foreign key (requested_product_id) references requested_product (requested_product_id)
);

create table shipment
(
    shipment_id         bigint auto_increment
        primary key,
    fee                 float        null,
    from_address        varchar(255) null,
    from_district_id    int          null,
    from_ward_code      varchar(255) null,
    ghn_service_id      int          null,
    ghn_service_type_id int          null,
    order_code          varchar(255) null,
    ship_type           varchar(255) null,
    shipping_unit       varchar(255) null,
    to_address          varchar(255) null,
    to_district_id      int          null,
    to_ward_code        varchar(255) null,
    guarantee_order_id  bigint       null,
    order_id            bigint       null,
    constraint FKc6ygijeao63iuxuoat3wx0mf1
        foreign key (guarantee_order_id) references guarantee_order (guarantee_order_id),
    constraint FKl7jthkq1uod13plb4g8y6u01c
        foreign key (order_id) references service_order (order_id)
);

create table transaction
(
    transaction_id   bigint auto_increment
        primary key,
    amount           float        null,
    created_at       datetime(6)  null,
    description      varchar(255) null,
    payment_for      varchar(255) null,
    status           bit          null,
    transaction_type varchar(255) null,
    order_deposit_id bigint       null,
    user_id          bigint       null,
    wallet_id        bigint       null,
    constraint UKag4ofuw48phbyl4in1gsi7ty2
        unique (order_deposit_id),
    constraint FKiyak0rquq8pcp3j1lx78r0xt8
        foreign key (order_deposit_id) references order_deposit (order_deposit_id),
    constraint FKsg7jp0aj6qipr50856wf6vbw1
        foreign key (user_id) references user (user_id),
    constraint FKtfwlfspv2h4wcgc9rjd1658a6
        foreign key (wallet_id) references wallet (wallet_id)
);

create table complaint
(
    complaint_id                 bigint auto_increment
        primary key,
    complaint_type               varchar(255)  null,
    created_at                   datetime(6)   null,
    description                  varchar(500)  null,
    order_status                 varchar(255)  null,
    proof_img_urls               varchar(2000) null,
    refund_amount                float         null,
    refund_percent               int           null,
    staff_response               varchar(500)  null,
    status                       varchar(255)  null,
    updated_at                   datetime(6)   null,
    woodworker_response          varchar(500)  null,
    refund_credit_transaction_id bigint        null,
    refund_debit_transaction_id  bigint        null,
    order_id                     bigint        null,
    staff_user_id                bigint        null,
    constraint UK7lm2d6kgxucldrranftmmo8oq
        unique (refund_credit_transaction_id),
    constraint UKrecxy2jg6wlg1l0nr026676tt
        unique (refund_debit_transaction_id),
    constraint FK9juwa1s4shnb349d9eoeri4u3
        foreign key (refund_credit_transaction_id) references transaction (transaction_id),
    constraint FKc4yu0lsa8xw7y74bi4s3bg99x
        foreign key (order_id) references service_order (order_id),
    constraint FKob0dwbyweie7kxpvg69bjk0cs
        foreign key (refund_debit_transaction_id) references transaction (transaction_id),
    constraint FKsbcgdok55e4i76kc2fvroylgh
        foreign key (staff_user_id) references user (user_id)
);

USE wdcrbp;

-- Service (Dịch vụ)
INSERT INTO wdcrbp.service (created_at, number_of_deposits, service_name, status, updated_at) VALUES ('2025-03-29 21:16:45.000000', 3, 'Personalization', true, '2025-03-29 21:17:00.000000');
INSERT INTO wdcrbp.service (created_at, number_of_deposits, service_name, status, updated_at) VALUES ('2025-03-29 21:17:06.000000', 2, 'Customization', true, '2025-03-29 21:17:14.000000');
INSERT INTO wdcrbp.service (created_at, number_of_deposits, service_name, status, updated_at) VALUES ('2025-03-29 21:17:18.000000', 2, 'Guarantee', true, '2025-03-29 21:17:28.000000');
INSERT INTO wdcrbp.service (created_at, number_of_deposits, service_name, status, updated_at) VALUES ('2025-03-29 21:17:34.000000', 1, 'Sale', true, '2025-03-29 21:19:33.000000');

-- Service Deposit (Tiền để đặt cọc)
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:21:31.000000', 1, 'Đặt cọc lần 1: Sau khi ký hợp đồng', 40, true, '2025-03-29 21:22:15.000000', 1);
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:22:20.000000', 2, 'Đặt cọc lần 2: Sau khi bàn giao thiết kế', 30, true, '2025-03-29 21:22:37.000000', 1);
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:22:41.000000', 3, 'Thanh toán còn lại: Sau khi nhận sản phẩm', 30, true, '2025-03-29 21:27:28.000000', 1);
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:27:38.000000', 1, 'Đặt cọc lần 1: Sau khi ký hợp đồng', 60, true, '2025-03-29 21:27:57.000000', 2);
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:28:07.000000', 2, 'Thanh toán còn lại: Sau khi nhận sản phẩm', 40, true, '2025-03-29 21:27:58.000000', 2);
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:28:14.000000', 1, 'Đặt cọc lần 1: Sau khi báo giá sửa chữa / bảo hành', 60, true, '2025-03-29 21:28:34.000000', 3);
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:28:15.000000', 2, 'Thanh toán còn lại: Sau khi nhận sản phẩm', 40, true, '2025-03-29 21:28:42.000000', 3);
INSERT INTO wdcrbp.service_deposit (created_at, deposit_number, description, percent, status, updated_at, service_id) VALUES ('2025-03-29 21:29:05.000000', 1, 'Thanh toán sau khi xác nhận mua', 100, true, '2025-03-29 21:38:39.000000', 4);

-- Service pack (Gói dịch vụ)
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ vàng của nền tảng', 1, 'Gold', true, 20, 500000, true, 100, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ bạc của nền tảng', 1, 'Silver', false, 10, 350000, true, 10, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ đồng của nền tảng', 1, 'Bronze', false, 5, 200000, false, 1, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ vàng của nền tảng', 3, 'Gold', true, 20, 1350000, true, 100, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ bạc của nền tảng', 3, 'Silver', false, 10, 945000, true, 10, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ đồng của nền tảng', 3, 'Bronze', false, 5, 540000, false, 1, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ vàng của nền tảng', 12, 'Gold', true, 20, 4800000, true, 100, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ bạc của nền tảng', 12, 'Silver', false, 10, 3360000, true, 10, true);
INSERT INTO wdcrbp.service_pack (description, duration, name, personalization, post_limit_per_month, price, product_management, search_result_priority, status) VALUES ('Gói dịch vụ đồng của nền tảng', 12, 'Bronze', false, 5, 1920000, false, 1, true);

-- Tech Spec (Thông số kỹ thuật)
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:52:05.000000', 'Chiều dài', 'number', true, '2025-03-29 20:52:12.000000');
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:53:42.000000', 'Chiều rộng', 'number', true, '2025-03-29 20:53:53.000000');
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:54:04.000000', 'Chiều cao', 'number', true, '2025-03-29 20:54:13.000000');
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:54:28.000000', 'Loại gỗ', 'select', true, '2025-03-29 20:54:39.000000');
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:54:44.000000', 'Hoàn thiện bề mặt', 'select', true, '2025-03-29 20:55:21.000000');
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:55:42.000000', 'Yêu cầu điêu khắc/trạm trổ', 'text', true, '2025-03-29 20:55:54.000000');
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:55:58.000000', 'Hình ảnh mẫu', 'file', true, '2025-03-29 20:56:19.000000');
INSERT INTO wdcrbp.tech_spec (created_at, name, option_type, status, updated_at) VALUES ('2025-03-29 20:56:26.000000', 'Yêu cầu đặc biệt', 'text', true, '2025-03-29 20:56:45.000000');

-- Tech Spec Value (Giá trị có thể chọn của thông số kỹ thuật)
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Gỗ sồi', 4);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Gỗ óc chó', 4);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Gỗ xoan đào', 4);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Gỗ gõ đỏ', 4);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('MDF/Plywood', 4);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Sơn PU bóng', 5);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Sơn PU mờ', 5);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Dầu lau', 5);
INSERT INTO wdcrbp.tech_spec_value (value, tech_spec_id) VALUES ('Phủ veneer', 5);

-- Category (Danh mục sản phẩm)
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('1', 'Giường', '2025-03-29 21:02:12.000000', 'Nội thất phòng ngủ', null, true, '2025-03-29 21:02:20.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('1', 'Tủ quần áo', '2025-03-29 21:02:34.000000', 'Nội thất phòng ngủ', null, true, '2025-03-29 21:02:35.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('1', 'Tủ đầu giường', '2025-03-29 21:03:10.000000', 'Nội thất phòng ngủ', null, true, '2025-03-29 21:03:34.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('1', 'Bàn trang điểm', '2025-03-29 21:03:45.000000', 'Nội thất phòng ngủ', null, true, '2025-03-29 21:03:52.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('1', 'Ghế', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', null, true, '2025-03-29 21:04:33.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('1', 'Bàn làm việc', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', null, true, '2025-03-29 21:02:20.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Giường truyền thống', '2025-03-29 21:03:45.000000', 'Nội thất phòng ngủ', 1, true, '2025-03-29 21:02:35.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Giường bệt', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 1, true, '2025-03-29 21:03:34.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Giường có hộc kéo', '2025-03-29 21:03:45.000000', 'Nội thất phòng ngủ', 1, true, '2025-03-29 21:03:52.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Giường phản', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 1, true, '2025-03-29 21:04:33.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Giường thông minh', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 1, true, '2025-03-29 21:02:20.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Tủ âm tường', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 2, true, '2025-03-29 21:02:35.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Tủ đứng độc lập', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 2, true, '2025-03-29 21:03:34.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Tủ mở', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 2, true, '2025-03-29 21:03:52.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Tủ kết hợp kệ trang trí hoặc bàn làm việc', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 2, true, '2025-03-29 21:04:33.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Tủ đơn', '2025-03-29 21:02:34.000000', 'Nội thất phòng ngủ', 3, true, '2025-03-29 21:02:35.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Tủ đôi', '2025-03-29 21:03:10.000000', 'Nội thất phòng ngủ', 3, true, '2025-03-29 21:03:34.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Tủ mở', '2025-03-29 21:03:45.000000', 'Nội thất phòng ngủ', 3, true, '2025-03-29 21:03:52.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn trang điểm treo tường', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 4, true, '2025-03-29 21:04:33.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn trang điểm có gương gập', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 4, true, '2025-03-29 21:02:20.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn trang điểm có hộc tủ chứa đồ', '2025-03-29 21:03:45.000000', 'Nội thất phòng ngủ', 4, true, '2025-03-29 21:02:35.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn trang điểm kết hợp bàn làm việc', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 4, true, '2025-03-29 21:03:34.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Ghế ngồi bàn trang điểm', '2025-03-29 21:03:45.000000', 'Nội thất phòng ngủ', 5, true, '2025-03-29 21:03:52.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Ghế đọc sách', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 5, true, '2025-03-29 21:04:33.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Ghế thư giãn', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 5, true, '2025-03-29 21:02:20.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn làm việc đơn giản', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 6, true, '2025-03-29 21:02:35.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn làm việc có hộc tủ kéo', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 6, true, '2025-03-29 21:03:34.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn làm việc kết hợp kệ sách', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 6, true, '2025-03-29 21:03:52.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn làm việc gấp gọn', '2025-03-29 21:05:40.000000', 'Nội thất phòng ngủ', 6, true, '2025-03-29 21:04:33.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('2', 'Bàn làm việc treo tường', '2025-03-29 21:04:12.000000', 'Nội thất phòng ngủ', 6, true, '2025-03-29 21:02:35.000000');
INSERT INTO wdcrbp.category (category_level, category_name, created_at, description, parent_id, status, updated_at) VALUES ('1', 'Khác', '2025-04-02 23:02:46.000000', 'Khác', null, true, '2025-04-02 23:02:56.000000');

-- Tài khoản
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-03-30 10:25:18.000000', 'admin@w.w', '$2a$10$2D75aL0EcnSvsxc0Sib9z.jyDgnUcCHKADckgo6Zy957tFaj4LTou', '0978281392', 'Admin', true, 'Admin');
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-03-30 10:25:19.000000', 'mod@w.w', '$2a$10$CnckC3Hls01TORObeQUUYuAWjfsxmGvP.c3CWQc0FOBPZS01j7vZy', '0971753392', 'Moderator', true, 'Moderator');
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-03-30 10:25:19.000000', 'staff@w.w', '$2a$10$IqhuZ93e8CZqrcSl5vXysewefN9iCTVUImC4a4ZshNTCnx0YFUMpS', '0151781392', 'Staff', true, 'Staff');
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-03-30 10:29:59.672069', 'ww@w.w', '$2a$10$IqhuZ93e8CZqrcSl5vXysewefN9iCTVUImC4a4ZshNTCnx0YFUMpS', '0971781392', 'Woodworker', true, 'Thợ Test Nền Tảng');
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-03-30 10:33:04.000000', 'cus@w.w', '$2a$10$lYt68IQ6HCMSvSSblHThoeS5fzEuqsMYOujBYcKQa8PcpgTXHyNV.', '0981781393', 'Customer', true, 'Khách Test Nền Tảng');
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-04-02 18:29:36.461431', 'luan@w.w', '$2a$10$TvstJei1iNs/YuEdQbXSXexwzWP28xkX9C9qsAmafaLPPSIeu4dl.', '0981781392', 'Woodworker', true, 'Thợ 1');
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-04-02 18:43:48.884318', 'nam@w.w', '$2a$10$7SoqvpPZ/FrlQgo1u55Lr.KiamQyoaRDI/vWDAINywKrTje52wi2W', '0981781391', 'Woodworker', true, 'Thợ 2');
INSERT INTO wdcrbp.user (otp, created_at, email, password, phone, role, status, username) VALUES (null, '2025-05-08 19:50:04.000000', 'trongluan115@gmail.com', '$2a$10$wGLLmSiD3Oh4ucz2VAoip.k2iF0hUvcWXtFaBMd3PfpGFILEpc2UK', '0971781359', 'Customer', true, 'Võ Trọng Luân');

-- Địa chỉ
INSERT INTO wdcrbp.user_address (address, city_id, created_at, district_id, is_default, ward_code, user_id) VALUES ('123 Nguyễn Văn Linh, Phường Hòa Minh, Quận Liên Chiểu, Đà Nẵng', '203', '2025-04-16 15:49:40.851664', '1530', true, '40505', 5);
INSERT INTO wdcrbp.user_address (address, city_id, created_at, district_id, is_default, ward_code, user_id) VALUES ('29/28 đường Nguyễn Công Trứ, Phường Hòa Minh, Quận Liên Chiểu, Đà Nẵng', '203', '2025-05-08 19:49:02.788634', '1530', true, '40505', 8);

-- Ví người dùng
INSERT INTO wdcrbp.wallet (balance, created_at, updated_at, user_id) VALUES (25200000, '2025-03-30 16:22:40.000000', '2025-04-29 12:10:04.093166', 4);
INSERT INTO wdcrbp.wallet (balance, created_at, updated_at, user_id) VALUES (30000000, '2025-03-30 16:22:41.000000', '2025-04-16 22:38:08.596170', 5);
INSERT INTO wdcrbp.wallet (balance, created_at, updated_at, user_id) VALUES (1640000, '2025-04-02 18:30:19.429407', '2025-04-29 12:11:44.071846', 6);
INSERT INTO wdcrbp.wallet (balance, created_at, updated_at, user_id) VALUES (3080000, '2025-04-02 18:44:05.257624', '2025-04-29 12:12:15.044321', 7);
INSERT INTO wdcrbp.wallet (balance, created_at, updated_at, user_id) VALUES (50000000, '2025-05-08 19:47:38.858336', '2025-05-08 19:49:45.602018', 8);

-- Các khoản giao dịch
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (30000000, '2025-04-16 22:38:19.148958', 'Nạp tiền vào ví', 'Ví', true, 'Nạp ví', null, 4, 1);
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (30000000, '2025-04-16 22:37:26.117234', 'Nạp tiền vào ví', 'Ví', true, 'Nạp ví', null, 5, 2);
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (30000000, '2025-04-16 22:38:19.148958', 'Nạp tiền vào ví', 'Ví', true, 'Nạp ví', null, 6, 3);
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (30000000, '2025-04-16 22:38:19.148958', 'Nạp tiền vào ví', 'Ví', true, 'Nạp ví', null, 7, 4);
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (4800000, '2025-04-29 12:10:04.113167', 'Thanh toán gói dịch vụ Gold', 'Gói dịch vụ', true, 'Thanh toán bằng ví', null, 4, 1);
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (3360000, '2025-04-29 12:11:44.083835', 'Thanh toán gói dịch vụ Silver', 'Gói dịch vụ', true, 'Thanh toán bằng ví', null, 6, 3);
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (1920000, '2025-04-29 12:12:15.051436', 'Thanh toán gói dịch vụ Bronze', 'Gói dịch vụ', true, 'Thanh toán bằng ví', null, 7, 4);
INSERT INTO wdcrbp.transaction (amount, created_at, description, payment_for, status, transaction_type, order_deposit_id, user_id, wallet_id) VALUES (50000000, '2025-05-08 19:49:20.979339', 'Nạp tiền vào ví', 'Ví', true, 'Nạp ví', null, 8, 5);

-- Woodworker Profile
INSERT INTO wdcrbp.woodworker_profile (address, bio, brand_name, business_type, city_id, created_at, district_id, img_url, no_order, public_status, rating, service_pack_end_date, service_pack_start_date, status, tax_code, total_reviews, total_star, updated_at, verification_stauts, ward_code, warranty_policy, service_pack_id, user_id) VALUES ('123 Nguyễn Văn Linh, Phường Tăng Nhơn Phú A, Thành Phố Thủ Đức, Hồ Chí Minh', 'Tại Mộc Chạm, chúng tôi không chỉ làm đồ gỗ – chúng tôi thổi hồn vào từng thớ gỗ. Với đội ngũ thợ mộc lành nghề và niềm đam mê với chất liệu tự nhiên, xưởng chuyên thiết kế – chế tác nội thất gỗ nguyên khối, thủ công tinh xảo và mang đậm bản sắc riêng.', 'Mộc Chạm', 'Hộ kinh doanh', '202', '2025-03-30 10:29:59.577928', '3695', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/ww-logo-5Thn0rbBpiKBYg9q9wxzMg3apVJRvX.jpg', null, true, 0, '2026-04-29 12:10:04.131167', '2025-04-29 12:10:04.131167', true, '1234567890', 0, 0, '2025-04-30 10:30:43.292165', null, '90755', 'Nứt, gãy ván gỗ;Cong vênh, vênh mặt bàn/mặt tủ;Bong tróc sơn/vecni/lớp hoàn thiện;Khớp nối lỏng, lắc;Chân đồ lệch, kênh kênh;Ngăn kéo kẹt hoặc trượt không mượt;Bong keo mối ghép;Mối mọt gỗ (nếu phát sinh trong thời gian bảo hành);Biến dạng do độ ẩm/thuỷ nhiệt;Lõm, trũng bề mặt', 7, 4);
INSERT INTO wdcrbp.woodworker_profile (address, bio, brand_name, business_type, city_id, created_at, district_id, img_url, no_order, public_status, rating, service_pack_end_date, service_pack_start_date, status, tax_code, total_reviews, total_star, updated_at, verification_stauts, ward_code, warranty_policy, service_pack_id, user_id) VALUES ('23 đường Trần Thái, Phường Phước Long A, Thành Phố Thủ Đức, Hồ Chí Minh', 'Xưởng mộc Bình Mộc là nơi hội tụ tinh hoa của nghề mộc, chuyên sản xuất và cung cấp nội thất phòng ngủ chất lượng cao. Với nhiều năm kinh nghiệm trong lĩnh vực, chúng tôi cam kết mang đến cho khách hàng những sản phẩm tinh tế, bền đẹp và phù hợp với mọi không gian sống.

Tại Bình Mộc, mỗi sản phẩm đều được chế tác tỉ mỉ từ những loại gỗ tốt nhất, đảm bảo sự chắc chắn và vẻ đẹp tự nhiên theo thời gian. Chúng tôi không ngừng đổi mới thiết kế, kết hợp giữa phong cách truyền thống và hiện đại để tạo nên những sản phẩm vừa tiện nghi, vừa đẳng cấp.

Sản phẩm của chúng tôi bao gồm giường ngủ, tủ quần áo, bàn trang điểm, kệ đầu giường và nhiều món đồ nội thất khác, giúp tối ưu không gian và mang lại sự thoải mái cho người sử dụng.

Bình Mộc luôn đặt chất lượng và sự hài lòng của khách hàng lên hàng đầu. Chúng tôi sẵn sàng tư vấn và thiết kế theo yêu cầu riêng, mang đến giải pháp nội thất hoàn hảo cho từng không gian.', 'Bình Mộc', 'Hộ kinh doanh', '202', '2025-04-02 18:29:36.375436', '3695', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/1-jiFGsd6iBFNsXtVuGkGybntJXrf00M.jpg', null, true, 0, '2026-04-29 12:11:44.097834', '2025-04-29 12:11:44.097834', true, '1234567890', null, null, '2025-04-02 18:30:15.697529', null, '90757', 'Nứt, gãy ván gỗ;Cong vênh, vênh mặt bàn/mặt tủ;Bong tróc sơn/vecni/lớp hoàn thiện;Khớp nối lỏng, lắc;Chân đồ lệch, kênh kênh;Ngăn kéo kẹt hoặc trượt không mượt;Bong keo mối ghép;Mối mọt gỗ (nếu phát sinh trong thời gian bảo hành);Biến dạng do độ ẩm/thuỷ nhiệt;Lõm, trũng bề mặt', 8, 6);
INSERT INTO wdcrbp.woodworker_profile (address, bio, brand_name, business_type, city_id, created_at, district_id, img_url, no_order, public_status, rating, service_pack_end_date, service_pack_start_date, status, tax_code, total_reviews, total_star, updated_at, verification_stauts, ward_code, warranty_policy, service_pack_id, user_id) VALUES ('12/12 đường Đồng Khởi, Xã Hòa Khương, Huyện Hòa Vang, Đà Nẵng', 'Xưởng mộc Hoa Nam là đơn vị chuyên sản xuất và cung cấp nội thất gỗ chất lượng cao, đặc biệt là nội thất phòng ngủ. Với nhiều năm kinh nghiệm trong nghề, chúng tôi tự hào mang đến những sản phẩm được chế tác tinh xảo, kết hợp giữa tay nghề truyền thống và công nghệ sản xuất hiện đại.

Điểm nổi bật của Hoa Nam:

Chất liệu gỗ tuyển chọn: Gỗ tự nhiên và gỗ công nghiệp cao cấp, đảm bảo độ bền và thẩm mỹ.

Thiết kế đa dạng: Từ phong cách cổ điển sang trọng đến hiện đại tối giản, phù hợp với mọi không gian.

Dịch vụ chuyên nghiệp: Tư vấn tận tâm, hỗ trợ lắp đặt và bảo hành sản phẩm lâu dài.

Hoa Nam luôn không ngừng đổi mới, sáng tạo để mang đến những sản phẩm nội thất đẹp, bền vững và tiện dụng. Chúng tôi cam kết trở thành đối tác tin cậy, đồng hành cùng khách hàng trong việc kiến tạo không gian sống đẳng cấp và ấm cúng.', 'Hoa Nam', 'Cá nhân', '203', '2025-04-02 18:43:48.798212', '1687', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/1-mlKYENspNAwxBX5HexnZInV9pJVwPL.jpg', null, true, 0, '2026-04-29 12:12:15.067321', '2025-04-29 12:12:15.067321', true, '1234467890', null, null, '2025-04-02 18:44:01.798269', null, '40603', 'Nứt, gãy ván gỗ;Cong vênh, vênh mặt bàn/mặt tủ;Bong tróc sơn/vecni/lớp hoàn thiện;Khớp nối lỏng, lắc;Chân đồ lệch, kênh kênh;Ngăn kéo kẹt hoặc trượt không mượt;Bong keo mối ghép;Mối mọt gỗ (nếu phát sinh trong thời gian bảo hành);Biến dạng do độ ẩm/thuỷ nhiệt;Lõm, trũng bề mặt', 9, 7);

-- Available Service
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-03-31 12:04:29.723159', 'Chuyên gia công giường, tủ, bàn ghế,... theo yêu cầu.', true, true, '2025-03-31 12:04:29.723159', 2, 1);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-03-31 12:04:29.735700', 'Cung cấp dịch vụ tùy chỉnh thiết kế nội thất hiện đại.', true, true, '2025-03-31 12:04:29.735700', 3, 1);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-03-31 12:04:29.744060', 'Bảo hành, sửa chữa, thay thế linh kiện,...', true, true, '2025-03-31 12:04:29.744060', 4, 1);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-03-31 12:04:29.752465', 'Bán hàng trong kho', true, true, '2025-03-31 12:04:29.752465', 1, 1);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:30:19.438884', null, true, true, '2025-04-02 18:30:19.438884', 2, 2);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:30:19.447251', null, true, true, '2025-04-02 18:30:19.447251', 3, 2);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:30:19.454706', null, true, true, '2025-04-02 18:30:19.454706', 4, 2);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:30:19.460704', null, true, false, '2025-04-02 18:30:19.460704', 1, 2);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:44:05.269012', null, true, true, '2025-04-02 18:44:05.269012', 2, 3);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:44:05.274993', null, true, true, '2025-04-02 18:44:05.274993', 3, 3);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:44:05.279185', null, true, false, '2025-04-02 18:44:05.279185', 4, 3);
INSERT INTO wdcrbp.available_service (created_at, description, operating_status, status, updated_at, service_id, woodworker_id) VALUES ('2025-04-02 18:44:05.282950', null, true, false, '2025-04-02 18:44:05.282950', 1, 3);

-- Bài đăng
INSERT INTO wdcrbp.post (created_at, description, img_urls, title, woodworker_id) VALUES ('2025-04-02 18:34:04.084982', 'Xưởng mộc Bình Mộc không chỉ là nơi sản xuất nội thất phòng ngủ mà còn là cái tên được vinh danh trong nhiều giải thưởng uy tín của ngành mộc. Chúng tôi tự hào khi những sản phẩm do mình chế tác đã được công nhận về thiết kế, chất lượng và độ bền, mang đến sự hài lòng cho khách hàng trên khắp cả nước.

Những thành tựu nổi bật của Bình Mộc:

Giải thưởng "Xưởng mộc xuất sắc trong thiết kế nội thất phòng ngủ"

Chứng nhận "Sản phẩm chất lượng cao – Được khách hàng tin dùng"

Đạt chuẩn kỹ thuật sản xuất hiện đại kết hợp tay nghề thủ công tinh xảo

Tại sao chọn Bình Mộc?

Tay nghề nghệ nhân lâu năm, chạm khắc tinh tế, tỉ mỉ đến từng chi tiết

Nguyên liệu gỗ tuyển chọn, đảm bảo độ bền và thẩm mỹ vượt trội

Thiết kế đa dạng, tùy chỉnh theo yêu cầu, phù hợp với mọi không gian sống

Quy trình sản xuất nghiêm ngặt, kiểm định chất lượng trước khi đến tay khách hàng', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/btd-GYj6EPfU4wHqomzB0PXMOyxqQ7GP3N.jpg;https://obb8igipjjs3uoho.public.blob.vercel-storage.com/tqa-ODknoXwy0AAeyxfKSDXnd5O6kCxfcP.jpg;https://obb8igipjjs3uoho.public.blob.vercel-storage.com/gg-CAUNSEIorARh56I9puP7gbqGu2ceZH.jpg', 'Bình Mộc – Chất Lượng Khẳng Định Bằng Giải Thưởng và Tay Nghề', 2);
INSERT INTO wdcrbp.post (created_at, description, img_urls, title, woodworker_id) VALUES ('2025-04-03 19:45:58.562409', 'Tay nghề vững chắc không chỉ đến từ kinh nghiệm mà còn được khẳng định qua những chứng chỉ nghề mộc uy tín. Tại xưởng mộc của chúng tôi, đội ngũ thợ đều được đào tạo bài bản và sở hữu chứng chỉ nghề chuyên nghiệp, đảm bảo từng sản phẩm đều đạt chuẩn về kỹ thuật, thẩm mỹ và độ bền.

Chứng chỉ nghề mộc của chúng tôi thể hiện:

Tay nghề cao, kỹ thuật chuẩn mực, gia công tỉ mỉ đến từng chi tiết.

Am hiểu sâu về chất liệu gỗ, xử lý chống cong vênh, mối mọt, đảm bảo độ bền vượt trội.

Ứng dụng công nghệ sản xuất hiện đại, kết hợp với tinh hoa thủ công truyền thống.

Khả năng thiết kế và thi công đa dạng, đáp ứng mọi yêu cầu từ đơn giản đến phức tạp.

Chúng tôi không chỉ tạo ra những sản phẩm nội thất đẹp mà còn mang đến chất lượng được chứng nhận. Mỗi món đồ đều là minh chứng cho sự khéo léo, tận tâm và chuyên môn cao của đội ngũ thợ mộc.', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/chung-chi-tho-moc-1-qb6LrhmYvcAnyDqvRsyzCHXeLIR3wh.jpg', 'Chứng Chỉ Nghề Mộc – Khẳng Định Tay Nghề, Nâng Tầm Chất Lượng', 1);

-- Ý tưởng thiết kế (Design Idea)
INSERT INTO wdcrbp.design_idea (description, img_urls, name, total_reviews, total_star, category_id, woodworker_id) VALUES ('ĐẶC ĐIỂM NỔI BẬT CỦA SẢN PHẨM
_ ĐƯỢC ĐỤC CHẠM BẰNG TAY bởi các nghệ nhân làng nghề gỗ ĐỒNG KỴ BẮC NINH
_ KẾT CẤU SẢN PHẨM vô cùng vững chắc được kết nối khớp mộng
_ GIÁ CẢ CẠNH TRANH bởi được sản xuất tại xưởng làng nghề gỗ ĐỒNG KỴ đã nổi tiếng từ rất lầu về truyền thông làng nghề về gỗ .
_ CÓ CẢ CHI NHÁNH 2 MIỀN BẮC - NAM đễ dễ dàng giao nhận hàng hóa giúp quý khách hàng dễ dàng mua hàng và đến tham quan mua sắm
NHẬN GIA CÔNG SẢN XUẤT THEO MẪU', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/gg-URP4KU5anNWh1hh1uKKqnRPU2QuGf3.jpg', 'Giường Gỗ Mẫu Hoàng Gia Hoa Lá Tây', 0, 0, 7, 1);
INSERT INTO wdcrbp.design_idea (description, img_urls, name, total_reviews, total_star, category_id, woodworker_id) VALUES ('Tủ quần áo đứng độc lập là lựa chọn hoàn hảo cho những ai mong muốn sự linh hoạt và tiện dụng trong không gian sống. Với thiết kế sang trọng, đường nét tinh tế, sản phẩm này không chỉ giúp lưu trữ quần áo gọn gàng mà còn tạo điểm nhấn thẩm mỹ cho phòng ngủ.

Đặc điểm nổi bật:

Thiết kế đa dạng: Nhiều kích thước, kiểu dáng phù hợp với mọi phong cách nội thất.

Chất liệu cao cấp: Gỗ tự nhiên hoặc gỗ công nghiệp chống ẩm, bền đẹp theo thời gian.

Không gian lưu trữ tối ưu: Ngăn treo rộng rãi, kệ chứa đồ tiện lợi, giúp sắp xếp trang phục khoa học.

Dễ dàng di chuyển: Không cố định vào tường, dễ thay đổi vị trí phù hợp với nhu cầu sử dụng.

Tùy chỉnh theo yêu cầu: Loại gỗ.

Tủ quần áo đứng độc lập không chỉ là nơi lưu trữ quần áo mà còn là một món nội thất giúp không gian trở nên gọn gàng, tiện nghi và hiện đại hơn.', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/tqa-zZz8f7WfogQUOpvtxYn0hZE1yrvCDD.jpg', 'Tủ quần áo hiện đại', null, null, 13, 2);
INSERT INTO wdcrbp.design_idea (description, img_urls, name, total_reviews, total_star, category_id, woodworker_id) VALUES ('Bàn trang điểm không chỉ là món nội thất tiện dụng mà còn là góc nhỏ giúp bạn bắt đầu ngày mới đầy tự tin. Với thiết kế tinh tế, chất liệu cao cấp và công năng tối ưu, sản phẩm này mang đến sự sang trọng và tiện nghi cho không gian phòng ngủ.

Đặc điểm nổi bật:

Thiết kế hiện đại và thanh lịch: Đa dạng phong cách từ tối giản đến cổ điển, phù hợp với mọi không gian.

Chất liệu bền đẹp: Gỗ tự nhiên hoặc gỗ công nghiệp cao cấp, bề mặt chống trầy xước, dễ dàng vệ sinh.

Gương soi chất lượng cao: Hình ảnh rõ nét, không bị méo, giúp bạn trang điểm dễ dàng hơn.

Hệ thống ngăn kéo thông minh: Tích hợp nhiều ngăn chứa, giúp sắp xếp mỹ phẩm, phụ kiện ngăn nắp.

Kích thước linh hoạt: Phù hợp với mọi diện tích, từ phòng ngủ rộng rãi đến không gian nhỏ gọn.

Bàn trang điểm không chỉ giúp bạn chăm sóc bản thân mà còn là điểm nhấn tinh tế, tạo nên sự sang trọng và ấm cúng cho căn phòng.', 'https://obb8igipjjs3uoho.public.blob.vercel-storage.com/btd-ogKCQm7J67CJL7iBGUy556oOCXhqso.jpg', 'Bàn trang điểm Á Châu mẫu A24', null, null, 4, 3);

-- Config của ý tưởng thiết kế
INSERT INTO wdcrbp.design_idea_config (design_idea_id, updated_at, description, specifications) VALUES (1, null, null, 'Kích thước (dài x rộng x cao - cm)');
INSERT INTO wdcrbp.design_idea_config (design_idea_id, updated_at, description, specifications) VALUES (1, null, null, 'Loại gỗ');
INSERT INTO wdcrbp.design_idea_config (design_idea_id, updated_at, description, specifications) VALUES (2, null, null, 'Kích thước (dài x rộng x cao - cm)');
INSERT INTO wdcrbp.design_idea_config (design_idea_id, updated_at, description, specifications) VALUES (3, null, null, 'Kích thước (dài x rộng x cao - cm)');
INSERT INTO wdcrbp.design_idea_config (design_idea_id, updated_at, description, specifications) VALUES (3, null, null, 'Số ngăn tủ');

-- Value config của ý tưởng thiết kế
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (1, null, '100 x 100 x 100');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (1, null, '90 x 90 x 90');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (2, null, 'Xoan');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (2, null, 'Sồi');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (3, null, '100 x 100 x 100');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (3, null, '90 x 90 x 90');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (4, null, '100 x 100 x 100');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (4, null, '90 x 90 x 90');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (5, null, '1');
INSERT INTO wdcrbp.design_idea_config_value (design_idea_config_id, updated_at, value) VALUES (5, null, '2');

-- Biến thể của ý tưởng thiết kế
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (5000000, 1);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (4500000, 1);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (4500000, 1);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (4000000, 1);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (2500000, 2);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (2000000, 2);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (2000000, 3);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (2200000, 3);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (3000000, 3);
INSERT INTO wdcrbp.design_idea_variant (price, design_idea_id) VALUES (3500000, 3);

-- Bảng nối giá trị cấu hình biến thể
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 1, 1);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 3, 1);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 1, 2);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 4, 2);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 2, 3);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 3, 3);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 2, 4);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 4, 4);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 5, 5);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 6, 6);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 7, 7);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 9, 7);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 7, 8);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 10, 8);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 8, 9);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 9, 9);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 8, 10);
INSERT INTO wdcrbp.design_idea_variant_config (updated_at, design_idea_config_value_id, design_idea_variant_id) VALUES (null, 10, 10);

-- Configuration
INSERT INTO wdcrbp.configuration (created_by, description, name, updated_at, value) VALUES (null, 'SampleContract', 'Điều khoản của nền tảng', '2025-04-24 13:53:38.323679', '1. Về vai trò các bên
Bên A (Thợ mộc): Người cung cấp dịch vụ/sản phẩm liên quan đến chế tác hoặc thi công đồ gỗ.
Bên B (Khách hàng): Người thuê dịch vụ hoặc đặt hàng qua nền tảng.
Bên C (Nền tảng): Đơn vị trung gian cung cấp hệ thống kết nối giữa Bên A và Bên B.
2. Phạm vi dịch vụ
Dịch vụ do Bên A trực tiếp thực hiện tại địa điểm đã thống nhất với Bên B.
Nhiệm vụ của Bên A: đảm bảo tiến độ thi công, chất lượng sản phẩm và phản hồi kịp thời cho Bên B.
Mọi thông tin về thời gian, giá cả, chi tiết công việc sẽ được thống nhất cụ thể trong mỗi đơn đặt dịch vụ.
3. Thanh toán và tiến độ
Khách hàng cần thanh toán đúng tiến độ đã thống nhất trong đơn hàng.
Thợ mộc sẽ chỉ bắt đầu hoặc tiếp tục công việc khi đã nhận được thanh toán đúng hạn.
Nền tảng có thể hỗ trợ cổng thanh toán online và theo dõi tiến độ qua hệ thống.');
INSERT INTO wdcrbp.configuration (created_by, description, name, updated_at, value) VALUES (null, 'vnp_secretKey', 'Secret key của VNPay', '2025-04-24 13:35:42.000000', 'QHRX1ELPYEDJQ2OE8WHORG63N9QZ8ZGQ');
INSERT INTO wdcrbp.configuration (created_by, description, name, updated_at, value) VALUES (null, 'vnp_TmnCode', 'Tmn code của Secret key của VNPay', '2025-04-24 13:35:43.000000', '74B7NM0Y');
INSERT INTO wdcrbp.configuration (created_by, description, name, updated_at, value) VALUES (null, 'GHN_Shop_ID', 'Shop id của GHN', '2025-04-24 13:35:46.000000', '196376');
INSERT INTO wdcrbp.configuration (created_by, description, name, updated_at, value) VALUES (null, 'GHN_Token_API', 'Token api của GHN', '2025-04-08 22:17:40.000000', 'aad4b91c-f670-11ef-bb13-2a342a4da1fb');
INSERT INTO wdcrbp.configuration (created_by, description, name, updated_at, value) VALUES (null, 'sendgrid_api_key', 'Send Grid API (Email)', '2025-05-09 15:08:39.000000', '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');

-- Product
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Oak', 'Tủ quần áo 2 cánh, ngăn kéo tiện dụng.', 50, false, 50, 'https://i.pinimg.com/1200x/23/90/bc/2390bc33a5b2cdb47d7aed90fd951ee0.jpg;https://i.pinimg.com/1200x/ec/cd/ed/eccdedd5bce6c583e67c006304dadc6a.jpg', 6200000, 'Tủ Quần Áo Đứng', 'Gỗ tự nhiên', 'Không', 'Ngăn kéo khóa', true, 7, 'Nordic', 0, 0, 24, 50, 'Gỗ sồi', 13, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Dark Brown', 'Bàn làm việc với kệ sách bên hông.', 50, false, 50, 'https://i.pinimg.com/1200x/ff/30/80/ff3080a470e4491a273d77c7e568a8d5.jpg', 4500000, 'Bàn Làm Việc Gỗ Tự Nhiên', 'Không mùi', 'Không', 'Kệ sách tích hợp', true, 4, 'Scandinavian', 0, 0, 12, 50, 'Gỗ xoan đào', 26, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Light Beige', 'Tủ đầu giường nhỏ gọn', 50, false, 50, 'https://i.pinimg.com/1200x/1d/ca/5f/1dca5fc43081c89cf0830404c698ebd6.jpg', 1800000, 'Tủ Đầu Giường Mini', 'Không', 'Không', 'Cửa lùa', true, 5, 'Minimalist', 0, 0, 6, 50, 'MDF', 3, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Chestnut', 'Bàn trang điểm gỗ tích hợp gương', 50, false, 50, 'https://i.pinimg.com/1200x/03/58/6e/03586e73e3a6e3dfb98d8c8fb9876a37.jpg', 5200000, 'Bàn Trang Điểm Gỗ Sồi', 'Không', 'Không', 'Ngăn hộc đa năng', true, 3, 'Contemporary', 0, 0, 18, 50, 'Gỗ sồi', 4, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Black', 'Tủ để sách 5 tầng bằng gỗ công nghiệp', 50, false, 50, 'https://i.pinimg.com/1200x/2f/18/76/2f1876cc63efe5a69210d1d67df75ffd.jpg', 2500000, 'Kệ Sách Đa Năng', 'Không', 'Không', 'Gấp gọn thông minh', true, 6, 'Japanese', 0, 0, 18, 50, 'Plywood', 31, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Natural', 'Ghế đọc sách thư giãn gỗ cao cấp.', 50, false, 50, 'https://i.pinimg.com/1200x/4e/3b/3d/4e3b3d92d11d2d42c9a155180a75aa74.jpg', 3100000, 'Ghế Đọc Sách Cao Cấp', 'Không', 'Khắc hoa văn lưng ghế', 'Gấp gọn', true, 9, 'Rustic', 0, 0, 10, 50, 'Gỗ gõ đỏ', 24, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('White', 'Tủ gỗ treo tường hiện đại.', 50, false, 50, 'https://i.pinimg.com/1200x/f6/ca/24/f6ca24e9520cee90e717094e986c2e59.jpg', 3900000, 'Tủ Treo Tường Phòng Ngủ', 'Không', 'Không', 'Cánh mở êm ái', true, 8, 'Modern', 0, 0, 20, 50, 'Gỗ công nghiệp', 13, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Gray', 'Bàn làm việc gấp gọn tiết kiệm không gian.', 50, false, 50, 'https://i.pinimg.com/1200x/be/8d/88/be8d888f80047d1c20036f0e98d55a3d.jpg', 2950000, 'Bàn Gấp Gọn Văn Phòng', 'Không', 'Không', 'Xếp gọn tiện lợi', true, 10, 'Compact', 0, 0, 8, 50, 'Gỗ ép', 6, 1);
INSERT INTO wdcrbp.product (color, description, height, is_install, length, media_urls, price, product_name, scent, sculpture, special_feature, status, stock, style, total_reviews, total_star, warranty_duration, width, wood_type, category_id, woodworker_id) VALUES ('Honey', 'Tủ kết hợp bàn làm việc thông minh.', 50, false, 50, 'https://i.pinimg.com/1200x/dd/4c/38/dd4c381eaa6230de70dd8250318d9037.jpg', 6900000, 'Tủ Kết Hợp Bàn Làm Việc', 'Không', 'Không', 'Kết hợp thông minh', true, 5, 'Smart', 0, 0, 36, 50, 'Gỗ sồi', 2, 1);


