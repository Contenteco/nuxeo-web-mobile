<@extends src="base.ftl">

<@block name="content">
<div data-role="page" data-add-back-btn="true">
    <#assign username = userMainInfo.user.username>
    <div data-role="header">
        <h1>${username}'s Profile</h1>
    </div>

    <div data-role="content" class="profile">
      <div class="white nospace profileDetail">
        <div class="avatar">
          <img src="${This.getAvatarURI(username)}" alt="Avatar">
        </div>
        <div class="profileInfo clear">
          <#if userMainInfo.user.firstName != "" && userMainInfo.user.firstName != "">
            <div class="name">
              ${userMainInfo.user.firstName} ${userMainInfo.user.lastName}
            </div>
	          <#else>
            <div class="name gray">
	            John Doe
            </div>
	          </#if>
          </div>
          <div class="email">
	          <#if userMainInfo.user.email != "">
	            <a href="mailto:${userMainInfo.user.email}">${userMainInfo.user.email}</a>
	          <#else>
	            No Mail information
	          </#if>
          </div>
          <div class="groups">
              <#if userMainInfo.user.groups?size =0>
                <span class="tag">No Group</span>
              <#else>
                <#list userMainInfo.user.groups as group>
	              <span class="tag">${group}</span>
	            </#list>
	          </#if>
	      </div>
        </div>
      <fieldset class="ui-grid-a">
        <div class="ui-block-a">
          <a href="?mode=edit" data-role="button">Edit</a>
        </div>
        <div class="ui-block-b">
          <a href="?mode=password" data-role="button">Password</a>
        </div>
      </fieldset>

      </div>
    </div>

    <#import "../../footer.ftl" as footer/>
    <@footer.basic />
</div>

</@block>
</@extends>
