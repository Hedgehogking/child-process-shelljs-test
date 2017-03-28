{% extends "../../../base_views/tpl_mobile_blank.volt" %}

{% block title %}{{ row['Title'] }}{% endblock %}

{% block head %}
    {% if _debug %}
        <link rel="stylesheet" href="/app/modules/invitative/css/mobile/detail.css?v={{ Version|default('') }}_20170328223827">
    {% else %}
        <link rel="stylesheet" href="/app/modules/invitative/css/mobile/detail.min.css?v={{ Version|default('') }}_20170328223827">
    {% endif %}
{% endblock %}

{% block body %}
    <!--loading-->
    <div id="loadingBox">
        <div id="loading"></div>
        <div id="loadingTips">0%</div>
    </div>
    <!--start of background image-->
    <div class="bg-image"
         style="background-image:url({% if row['BgImageUrl'] %}{{ row['BgImageUrl'] }}{% else %}/app/modules/invitative/images/mobile/bg_640x1008.jpg{% endif %}) ">
        {% if row['BgMusicUrl'] %}
            <a class="btn-music btn-on" id="btnMusic" href="javascript:void(0);"> </a>
            <audio id="bgMusic" src="{{ row['BgMusicUrl'] }}" controls loop></audio>
        {% endif %}
    </div>
    <!-- start of page-home -->
    <div class="page-home bg-image hide-block" id="pageHome"
         style="background-image:url({% if row['CoverImageUrl'] %}{{ row['CoverImageUrl'] }}{% else %}/app/modules/invitative/images/mobile/img_cover_550x900.jpg{% endif %})">
        <a href="javascript:void(0);" class="btn-circle" id="btnCircle"></a>

        <div class="img-finger" id="imgFinger"></div>
    </div>
    <!-- start of page-content -->
    <div class="page-content" id="pageCon">
        <h1 class="con-title dot txt-overflow" id="pageConTitle">{{ row['Title'] }}</h1>
        {% if row['EnableShowParticipantList'] %}
            <div class="tip-vip-wrap"><a class="tip-vip" id="btnTipVip" href="#pageVip">贵宾</br>名单</a></div>
        {% endif %}
        <a class="activity-info" id="actTipInfo" href="#pageDetail">邀约详情</a>
        {% if IsSignUp %}
            <div class="btn-wrap btn-pass"><a href="javascript:void(0);" class="btn-tip">入场券</a></div>
        {% else %}
            {% if IsFull %}
                <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">已满员</a></div>
            {% else %}
                {% if IsNotStart or IsExpired %}
                    {% if IsNotStart %}
                        <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">未开始</a></div>
                    {% else %}
                        <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">已结束</a></div>
                    {% endif %}
                {% else %}
                    <div class="btn-wrap btnSignUp"><a href="javascript:void(0);" class="btn-tip">报名</a></div>
                {% endif %}
            {% endif %}
        {% endif %}

        <div class="activity-wrap">
            <div class="banner-wrap">
                <div class="swiper-container" id="ConBanner">
                    <div class="img-wrap swiper-wrapper">
                        {% for Image in row['ImagesUrl'] %}
                            <img class="swiper-slide img-width-100" src="{{ Image }}" alt=""/>
                        {% endfor %}
                    </div>
                    <div class="pagination"></div>
                </div>
            </div>
            <div class="activity-other-info swiper-container" id="actInfo">
                <div class="swiper-wrapper">
                    <div class="time swiper-slide"><i class="icon-size fa fa-clock-o"></i>报名时间:
                        <p>{{ date('Y-m-d H:i',row['StartTime']) }} 至 {{ date('Y-m-d H:i',row['EndTime']) }} </p>
                    </div>
                    <div class="time swiper-slide"><i class="icon-size fa fa-clock-o"></i>活动时间:
                        <p>{{ date('Y-m-d H:i',row['EventStartTime']) }}
                            至 {{ date('Y-m-d H:i',row['EventEndTime']) }} </p>
                    </div>
                    <div class="address swiper-slide"><i class="icon-size fa fa-map-marker"></i>地址:
                        <p>{{ row['Address'] }}<a href="{{ LocationUrl }}" class="icon-location"></a></p>
                    </div>
                </div>
                <div class="swiper-scrollbar"></div>
            </div>
        </div>
    </div>
    <!-- start of page-detail -->
    <div class="page-detail" id="pageDetail">
        <a href="#pageCon" class="btn-back"></a>

        <h1 class="con-title txt-overflow">{{ row['Title'] }}</h1>
        {% if IsSignUp %}
            <div class="btn-wrap btn-pass"><a href="javascript:void(0);" class="btn-tip">入场券</a></div>
        {% else %}
            {% if IsFull %}
                <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">已满员</a></div>
            {% else %}
                {% if IsNotStart or IsExpired %}
                    {% if IsNotStart %}
                        <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">未开始</a></div>
                    {% else %}
                        <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">已结束</a></div>
                    {% endif %}
                {% else %}
                    <div class="btn-wrap btnSignUp"><a href="javascript:void(0);" class="btn-tip">报名</a></div>
                {% endif %}
            {% endif %}
        {% endif %}
        <div class="org-wrap dot">
            <p class="sponsor-wrap">主办方：{{ row['Sponsor'] }}</p>
            {% if row['EnableShowParticipantLimit'] %}
                <p class="join-num txt-overflow">人数：{{ row['ParticipantLimit'] > 0 ? row['ParticipantLimit'] : '无限制' }}</p>
            {% endif %}
        </div>
        <div class="swiper-container org-con-wrap" id="orgConWrap">
            <div class="swiper-wrapper">
                <div class="org-detail-info swiper-slide">
                    {{ row['Description'] }}
                </div>
            </div>
            <div class="swiper-scrollbar"></div>
        </div>
    </div>
    <!-- start of page-vip -->
    <div class="page-vip" id="pageVip">
        <a href="#pageCon" class="btn-back"></a>

        <h1 class="vip-title dot" id="vipNum"></h1>
        {% if IsSignUp %}
            <div class="btn-wrap btn-pass"><a href="javascript:void(0);" class="btn-tip">入场券</a></div>
        {% else %}
            {% if IsFull %}
                <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">已满员</a></div>
            {% else %}
                {% if IsNotStart or IsExpired %}
                    {% if IsNotStart %}
                        <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">未开始</a></div>
                    {% else %}
                        <div class="btn-wrap"><a href="javascript:void(0);" class="btn-tip">已结束</a></div>
                    {% endif %}
                {% else %}
                    <div class="btn-wrap btnSignUp"><a href="javascript:void(0);" class="btn-tip">报名</a></div>
                {% endif %}
            {% endif %}
        {% endif %}
        <div class="guest-outer-wrap">
            <div class="preloader"> 努力加载中...</div>
            <div class="vip-wrap swiper-container" id="guestList">
                <ul class="guest-list swiper-wrapper" id="guestListWrap">
                </ul>
                <div class="swiper-scrollbar"></div>
            </div>
        </div>
    </div>
    <!-- start of page-success -->
    <div class="page-success" id="pageSuccess">
        <a href="javascript:void(0);" class="btn-back"></a>

        <h1 class="con-title dot txt-overflow">入场卷</h1>

        <div class="ticket ticket-used" id="ticketUsed"></div>
        {% if data_row['IsVerify'] %}
            <div class="ticket ticket-used" style="display: block"></div>
        {% endif %}
        <div class="swiper-container" id='successWrap'>
            <div class="swiper-wrapper">
                <div class="swiper-slide" id="swipeWrap">
                    <p class="contact-row" id="suName"><span>姓名:</span>{{ data_row['Name'] }}</p>

                    <p class="contact-row" id="suMobile"><span>联系电话:</span>{{ data_row['Mobile'] }}</p>
                    {% if row['Fields'] %}
                        {% for field in row['Fields'] %}
                            <p class="contact-row extend">
                                <span>{{ field['LabelName'] }}:</span>{{ data_row['Extend'][field['FieldName']] }}
                            </p>
                        {% endfor %}
                    {% endif %}
                    <img class="qr" id="qr" src="{{ VerifyUrl }}" alt=""/>

                    <p class="txt-tips">温馨提示：请由商家工作人员扫描二维码 电子门票，门票一经扫描即为失效.</p>
                </div>
            </div>
            <div class="swiper-scrollbar"></div>
        </div>
    </div>
    <!--signup-->
    <div id="mask" class="hide-block"></div>
    <form class="page-sign-up" id="signUp">
        <a href="#pageCon" class="btn-back"></a>

        <div class="top-wrap" id="topWrap">
            <div class="avatar"><img src="{{ Avatar }} " onerror="this.src='/assets/images/default_avatar.png'" alt=""/>
            </div>
            <h2 class="nick-name">{{ NickName }}</h2>
        </div>

        <div class="swiper-container" id="formWrap">
            <div class="swiper-wrapper" id="">
                <div class="swiper-slide text">
                    <input type="text" name="Name" data-role="text" id="" placeholder="姓名" data-rule-required="1"/>
                </div>
                <div class="swiper-slide text">
                    <input type="tel" name="Mobile" data-role="tel" id="" placeholder="电话号码" data-rule-required="1"/>
                </div>
                {% for Field in row['Fields'] %}
                    {% if Field['FieldType']=='text' or Field['FieldType']=='email' %}
                        <div class="swiper-slide text">
                            <input type="{{ Field['FieldType'] }}" data-role="{{ Field['FieldType'] }}"
                                   name="Extend[{{ Field['FieldName'] }}]" id="" placeholder="{{ Field['LabelName'] }}"
                                   data-rule-required="{{ Field['Required'] }}"/>
                        </div>
                    {% elseif Field['FieldType']=='mobile' %}
                        <div class="swiper-slide text">
                            <input type="tel" name="Extend[{{ Field['FieldName'] }}]" id=""
                                   placeholder="{{ Field['LabelName'] }}" data-rule-required="{{ Field['Required'] }}"/>
                        </div>
                    {% elseif Field['FieldType']=='textarea' %}
                        <div class="swiper-slide text">
                            <textarea name="Extend[{{ Field['FieldName'] }}]" id=""
                                      placeholder="{{ Field['LabelName'] }}"
                                      data-rule-required="{{ Field['Required'] }}"></textarea>
                        </div>
                    {% elseif Field['FieldType']=='region' %}
                        <div class="swiper-slide text">
                            <div class="multilevelselect" data-role="multilevelselect"
                                 data-placeholder="{{ Field['LabelName'] }}" data-required="{{ Field['Required'] }}">
                                <h2 class="select-group-title">{{ Field['LabelName'] }}</h2>

                                <div class="select-group inline-group">
                                    <div data-type="select" class="form-item select-area ">
                                        <div class="select-option" data-type="option"
                                             data-value="">省份
                                        </div>
                                        <i class="select-arrow fa fa-chevron-down"></i></div>
                                    <!-- 下拉菜单框-下拉控件 -->
                                    <select name="Extend[{{ Field['FieldName'] }}][Province]" class="form-item select">
                                        <option value="">请选择</option>

                                    </select></div>
                                <div class="select-group inline-group">
                                    <div data-type="select" class="form-item select-area ">
                                        <div class="select-option" data-type="option"
                                             data-value="">城市
                                        </div>
                                        <i class="select-arrow fa fa-chevron-down"></i></div>
                                    <!-- 下拉菜单框-下拉控件 -->
                                    <select name="Extend[{{ Field['FieldName'] }}][City]" class="form-item select">
                                        <option value="">请选择</option>
                                    </select></div>
                                <div class="select-group inline-group">
                                    <div data-type="select" class="form-item select-area ">
                                        <div class="select-option" data-type="option"
                                             data-value="">地区
                                        </div>
                                        <i class="select-arrow fa fa-chevron-down"></i></div>
                                    <!-- 下拉菜单框-下拉控件 -->
                                    <select name="Extend[{{ Field['FieldName'] }}][District]" class="form-item select">
                                        <option value="">请选择</option>
                                    </select></div>
                            </div>
                        </div>
                    {% endif %}
                {% endfor %}
            </div>
            <div class="swiper-scrollbar"></div>
        </div>
        <p class="error" id="errorTips">请填写真实姓名以便我们联系您，谢谢！</p>
        <button type="button" class="btn-submit" id="btnSubmit">接受邀请</button>
    </form>
{% endblock %}

{% block foot %}
    {{ super() }}
    <script type="text/javascript">
        var params = {
            TID: "{{ row['TID'] }}",
            _id: "{{ row['_id'] }}",
            IsSignUp: "{{ IsSignUp }}",
            IsFull: "{{ IsFull }}",
            isPlayMusic: "{{ row['BgMusicUrl'] }}",
            'FollowQRCode': "{{ FollowQRCodeUrl|default('') }}"
        };
    </script>
    {% if _debug %}
        <script src="/app/modules/invitative/script/mobile/detail.js?v={{ Version|default('') }}_20170328223823"></script>
    {% else %}
        <script src="/app/modules/invitative/script/mobile/detail.min.js?v={{ Version|default('') }}_20170328223823"></script>
    {% endif %}
{% endblock %}
