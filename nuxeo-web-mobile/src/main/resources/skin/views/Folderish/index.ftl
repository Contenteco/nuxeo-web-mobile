<@extends src="base.ftl">

<@block name="content">
<div data-role="page">

    <div data-role="header">
        <a href="#" data-rel="back" data-icon="arrow-l">Back</a>
        <h1>${Context.getMessage('label.header.title.Content')}</h1>
    </div>

    <div data-role="content" class="browse">
      <#if Adapter.children?size == 0>
        <p class="feedback">
          ${Context.getMessage('label.message.NoDocumentInFolder')}
        </p>
      </#if>
      <#list Adapter.children as child>
        <ul data-role="listview" class="ui-listview">
          <li class="ui-btn ui-btn-icon-right ui-li-has-arrow ui-li ui-li-has-count ui-li-has-icon ui-btn-up-c">
            <#if child.isFolder>
              <a class="ui-link-inherit" href="${Root.path}/doc/${child.id}/@folderish">
            <#else>
              <a class="ui-link-inherit" href="${Root.path}/doc/${child.id}">
            </#if>
            <#if child.common.icon != null && child.common.icon != "">
                <img class="ui-li-icon ui-li-thumb" src="${skinPath}${child.common.icon}" />
            <#else>
                <img class="ui-li-icon ui-li-thumb" src="${skinPath}icons/file.gif" />
            </#if>
                <h3>${child.title}</h3>
                <#if child.dublincore.description == null || child.dublincore.description == "" >
                  <p class="ui-li-desc">&nbsp;</p>
                <#else>
                  <p class="ui-li-desc">${child.dublincore.description}</p>
                </#if>
              </a>
          </li>
        </ul>
      </#list>
    </div>
    <#import "/footer.ftl" as footer/>
    <@footer.basic />
</div>

</@block>
</@extends>
