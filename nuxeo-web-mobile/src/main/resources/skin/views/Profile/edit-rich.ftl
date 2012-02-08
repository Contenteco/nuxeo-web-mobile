<@extends src="base.ftl">

<@block name="content">
<div data-role="dialog">
    <#assign username = userMainInfo.user.username>
    <div data-role="header">
        <h1>Edit</h1>
    </div>

    <div data-role="content" class="profile">
            <div class="white nospace profileDetail">
        <form method="post">
          <div class="avatar">
            <img src="${This.getAvatarURI(username)}" alt="Avatar">
          </div>
          <div class="profileInfo clear">
            <div class="name">
              <div class="marginBottom">
                <input type="text" name="user:firstName" value="${userMainInfo.user.firstName}" placeholder="First Name">
              </div>
              <div class="email">
                <input type="text" name="user:lastName" value="${userMainInfo.user.lastName}" placeholder="Last Name">
              </div>
            </div>
            <div class="email">
              <input type="text" name="user:email" value="${userMainInfo.user.email}" placeholder="User Mail">
            </div>
            <div class="groups">
              <label class="gray">Groups:</label>
              <#if userMainInfo.user.groups?size =0>
                <span class="tag">No Group</span>
              <#else>
                <#list userMainInfo.user.groups as group>
                    <span class="tag">${group}</span>
                  </#list>
                </#if>
              </div>
          </div>
            <div class="moreInfo">
              <ul data-inset="true" data-role="listview" class="ui-listview ui-listview-inset ui-corner-all ui-shadow">
                <li data-role="fieldcontain" class="ui-field-contain ui-body ui-br ui-li ui-li-static ui-body-c ui-corner-top ui-btn-up-c">
                  <label for="name" class="ui-input-text">Phone number</label>
                  <input type="text" name="" value="${userProfile.userprofile.phonenumber}" placeholder="Phone Number"></input>
                </li>
	            <li data-role="fieldcontain" class="ui-field-contain ui-body ui-br ui-li ui-li-static ui-body-c ui-corner-top ui-btn-up-c">
	              <label for="name" class="ui-input-text">Birth Date</label>
	              <#if userProfile.userprofile.birthdate != "">
	                <span>${userProfile.userprofile.birthdate?date}</span>
	              </#if>
	            </li>
	            <li data-role="fieldcontain" class="ui-field-contain ui-body ui-br ui-li ui-li-static ui-body-c ui-corner-top ui-btn-up-c">
	              <label for="name" class="ui-input-text">Gender</label>
	              <#if userProfile.userprofile.gender = true>
	                <span>Male</span>
	              <#else>
	                <span>Female</span>
	              </#if>
	            </li>
                <!--li data-role="fieldcontain" class="clear ui-field-contain ui-body ui-br ui-li ui-li-static ui-body-c ui-corner-top ui-btn-up-c">
                  <label class="gray ui-input-text">Gender</label>
                  <fieldset data-role="controlgroup">
                    <input type="radio" name="true" id="true" value="true" checked="checked" />
                    <label class="radioLabel" for="true">Male</label>
                    <input type="radio" name="false" id="false" value="false"  />
                    <label class="radioLabel" for="false">Female</label>
                  </fieldset>
                </li-->
                </ul>
            </div>
            <fieldset class="ui-grid-a">
              <div class="ui-block-a">
                <button data-rel="back" class="ui-btn-text" data-theme="b">Save</button>
              </div>
              <div class="ui-block-b">
                <a href="#" data-rel="back" data-role="button" data-theme="c">Cancel</a>
              </div>
            </fieldset>
        </form>
      </div>
    </div>

</div>

</@block>
</@extends>