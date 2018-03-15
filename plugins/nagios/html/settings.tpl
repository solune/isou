<form method="post" action="{$smarty.const.URL}/index.php/configuration/plugins/{$plugin->codename}">

    {include file="common/messages_form.tpl"}

    <fieldset>
        <legend>{$plugin->name}</legend>

        <dl>
            <div class="form-group">
                <dt class="form-topics-dt">
                    <label for="plugin-nagios-enable">Activer</label>
                </dt>
                <dd class="form-values-dd">
                    {html_radios id="plugin-nagios-enable" name="plugin_nagios_enable" options=$options_yes_no selected=$plugin->active}
                </dd>
            </div>
            <div class="form-group">
                <dt class="form-topics-dt">
                    <label for="plugin-nagios-path">Chemin du fichier status.dat</label>
                </dt>
                <dd class="form-values-dd">
                    <input class="input-extra-large" type="text" name="plugin_nagios_path" id="plugin-nagios-path" value="{$plugin->settings->statusdat_path}" /><br />
                    <span id="localauthentificationpath-aria-describedby">exemple : /var/share/nagios/status.dat</span>
                </dd>
            </div>
        </dl>
    </fieldset>

    <ul class="list-inline">
        <li>
            <input class="btn btn-primary" type="submit" value="enregistrer" />
        </li>
    </ul>
</form>
