<#macro "emailSubject">[Nuxeo] ${This.getDisplayPrincipalName()} shared the document ${Document.title}</#macro>

<#macro "emailBody" document>
  Hi,%0D
  %0D
  ${This.getDisplayPrincipalName()} thought you%27d like ${document.title}: ${This.getJSFURLPath(document)
}.%0D
  %0D
  %0D
  Updated: ${document.dublincore.modified.time?datetime}%0D
  Created: ${document.dublincore.created?datetime}%0D
  Author: ${This.getDisplayPrincipalName(document.dublincore.creator)}%0D
  %0D
  Location: ${document.path}%0D
  State: ${document.lifeCycleState}%0D
  Version: ${document.versionLabel}%0D
</#macro>

<@extends src="base.ftl">
<@block name="content">

<div data-role="page">
    <script type="text/javascript">
    $(function() {
      $.ajax({
        url: '${Root.path}/doc/${This.document.id}/hasLiked',
        success: function(data) {
          $("#like-button").removeClass('ui-disabled');
          if(JSON.parse(data).hasLiked) {
            setTimeout(function() {
              $("#like-button img").toggle();
            }, 100); //Delay toggle ...
          }
        }
      })

      $('#like-button').click(function() {
          $.ajax({
            url: '${Root.path}/doc/${This.document.id}/like'
          }).done(function() {
              $("#like-button img").toggle();
              $("#like-button").removeClass("ui-btn-active");
          }).fail(function() {
            alert('Something went wrong while liking your document.')
          });
      });
    });
    </script>
  
    <div data-role="header">
        <a href="#" data-rel="back" data-icon="arrow-l">Back</a>
        <h1>${Context.getMessage('label.header.title.View')}</h1>
    </div>

    <div data-role="content" class="documentView" id="main">
      <#assign doc = This.document>
      <div id="${doc.id}" title="Details"  class="panel">
        <div class="white nospace shadow documentInfo">
          <div class="title">
            <img alt="Document icon" src="${basePath}/..${doc.common.icon}" />${doc.dublincore.title}
          </div>
          <div class="description">${doc.dublincore.description}</div>
          <div class="modificationDate">
            <#if doc.dublincore.modified != null>
              <span>modified</span>
              <span>${doc.dublincore.modified.time?datetime}</span>
            </#if>
          </div>
          <div class="participants">
            <#list doc.dublincore.contributors as contributor>
              <#if contributor != "system">
                <span class="tag">
                  <a href="${Root.path}/profile/${contributor}">${This.getDisplayPrincipalName(contributor)}</a>
                </span>
              </#if>
            </#list>
          </div>
        </div><!-- documentInfo -->

        <div data-role="navbar" class="noSidespace">
          <ul>
            <#if This.hasPreview()>
              <li><a data-ajax="false" href="${This.previewURL}"><img alt="${Context.getMessage('label.header.title.Preview')}" src="${skinPath}/icons/preview.png" /></a></li>
            </#if>
            <#if doc.schemas?seq_contains("note")>
              <li><a href="${Root.path}/doc/${doc.id}/@preview"><img alt="${Context.getMessage('label.header.title.Preview')}" src="${skinPath}/icons/preview.png" /></a></li>
            </#if>
            <#if doc.isFolder>
              <li>
                <a href="${Root.path}/doc/${doc.id}/@folderish"><img alt="${Context.getMessage('label.header.title.Content')}" src="${skinPath}/icons/preview.png" /></a>
              </li>
            </#if>
            <li><a href="${Root.path}/doc/${doc.id}/@comment"><img alt="${Context.getMessage('label.header.title.Comments')}" src="${skinPath}/icons/comments.png" /></a></li>
            <li><a href="${Root.path}/doc/${doc.id}/@annotations"><img alt="${Context.getMessage('label.header.title.Annotations')}" src="${skinPath}/icons/annotations.png" /></a></li>
            <!-- Distabled yet
            <li><a href="${Root.path}/doc/${doc.id}/@relation"><img alt="${Context.getMessage('label.header.title.Relations')}" src="${skinPath}/icons/relations.png" /></a></li>
            -->
            <li>
              <a href="#" id="like-button" class="ui-disabled">
                <img src="${skinPath}/icons/liked.png" style="display: none;" alt="Like"/>
                <img src="${skinPath}/icons/like.png" alt="Unlike" />
              </a>
            </li>
          </ul>
        </div>

        <ul data-role="listview" data-inset="true">
          <li class="nxDocumentItem">
            <a href="mailto:?cc=${This.principal.email}&amp;subject=<@emailSubject/>t&amp;body=<@emailBody document=doc/>">
              ${Context.getMessage('label.action.MailIt')}
            </a>
          </li>
          <#if hasBlob>
          <li class="nxDocumentItem">
            <#if Context.getProperty('Cordova')??>
            <a red="external" target="_blank" data-ajax="false" href="javascript:NXCordova.downloadFromURL('${This.downloadURL}');">
            <#else>
            <a red="external" target="_blank" data-ajax="false" href="${This.downloadURL}">
            </#if>
              ${Context.getMessage('label.action.Download')}
            </a>
          </li>
          </#if>
          <!-- Disabled ...
          <li class="nxDocumentItem">
            <a href="#" 
               onclick="var jqxhr = $.get('${Root.path}/doc/${doc.id}/mailIt', function() { displayNotification('${Context.getMessage('label.message.RequestSent')}'); })
                .success(function() { displayNotification('${Context.getMessage('label.message.MailSent')}'); })
                .error(function() { displayNotification('${Context.getMessage('label.message.ProblemOccured')}'); })">
              ${Context.getMessage('label.action.MailMe')}
            </a>
          </li>-->
          <!-- Disable until we found a navigation management solution -->
          <!--li class="nxDocumentItem">
            <a href="${Root.path}/doc/${doc.id}?mode=edit">
              ${Context.getMessage('label.action.Edit')}
            </a>
          </li>
          <li class="nxDocumentItem">
            <a href="#" onclick="${Root.path}/doc/${doc.id}?mode=delete-confirmation" data-rel="dialog">
              ${Context.getMessage('label.action.Delete')}
            </a>
          </li-->
        </ul>
        
        <div data-role="collapsible-set" data-content-theme="d">
          <h2>${Context.getMessage('action.view.metadata.common')}</h2>
          <div data-role="collapsible" data-collapsed="false" data-content-theme="c">
            <h3>Dublincore</h3>
            <ul data-inset="true" data-role="listview" data-theme="d">
              <li data-role="fieldcontain">
                <label for="name" class="ui-input-text">${Context.getMessage('label.dublincore.created')}</label>
                <span><#if doc.dublincore.created != "">${doc.dublincore.created}</#if></span>
              </li>
              <li data-role="fieldcontain">
                <label for="name" class="ui-input-text">${Context.getMessage('label.dublincore.modified')}</label>
                <span><#if doc.dublincore.modified != "">${doc.dublincore.modified.time?datetime}</#if></span>
              </li>
              <li data-role="fieldcontain">
                <label for="name" class="ui-input-text">${Context.getMessage('label.dublincore.lastContributor')}</label>
                <span>${This.getDisplayPrincipalName(doc.dublincore.lastContributor)}</span>
              </li>
              <li data-role="fieldcontain">
                <label for="name" class="ui-input-text">${Context.getMessage('label.dublincore.creator')}</label>
                <span>${This.getDisplayPrincipalName(doc.dublincore.creator)}</span>
              </li>
              <li data-role="fieldcontain">
                <label for="name" class="ui-input-text">${Context.getMessage('label.dublincore.contributors')}</label>
                <span>
                <#list doc.dublincore.contributors as contributor>
                ${This.getDisplayPrincipalName(contributor)}<#if x_has_next>, </#if>
                </#list>
                </span>
              </li>
            <ul>
          </div>
        </div>
        
      </div>
    </div>
    
    <#import "/footer.ftl" as footer/>
    <@footer.basic />
  </div>

</@block>
</@extends>
