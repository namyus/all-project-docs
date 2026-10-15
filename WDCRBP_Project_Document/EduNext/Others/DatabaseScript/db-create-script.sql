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
    agreement             varchar(255)  null,
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


