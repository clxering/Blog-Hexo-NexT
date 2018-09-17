<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.footer.icon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>
  
<div class="author" itemprop="copyrightHolder">
	{% if theme.social %}
            <div class="links-of-author" style="margin:0">
                {% for name, link in theme.social %}
                  <span class="links-of-author-item">
                    <a href="{{ link.split('||')[0] | trim }}" target="_blank" title="{{ name }}" style="border-bottom:none;font-size: 22px">
                      {% if theme.social_icons.enable %}
                        <i class="fa fa-fw fa-{{ link.split('||')[1] | trim }}"></i>{#
                    #}{% endif %}{#
                      #}{% if not theme.social_icons.icons_only %}{#
                        #}{{ name }}{#
                      #}{% endif %}{#
                  #}</a>
                  </span>
                {% endfor %}
            </div>
    {% endif %}
</div>

  {% if theme.post_wordcount.totalcount %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.post_wordcount.item_text %}
      <span class="post-meta-item-text">{{ __('post.totalcount') }}&#58;</span>
    {% endif %}
    <span title="{{ __('post.totalcount') }}">{#
    #}{{ totalcount(site, '0,0.0a') }}{#
  #}</span>
  {% endif %}
</div>



{% if theme.footer.custom_text %}
  <div class="footer-custom">{#
  #}{{ theme.footer.custom_text }}{#
#}</div>
{% endif %}
