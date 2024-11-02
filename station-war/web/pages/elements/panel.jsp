
<%
String lien=(String)session.getValue("lien");
String but=(String)request.getParameter("but");
%>

<aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
          <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-language"></i></a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
          <!-- Home tab content -->
          <div class="tab-pane" id="control-sidebar-home-tab">
            <h3 class="control-sidebar-heading">Option langage</h3>
            <form method="post" action="<%=lien%>?but=<%=but%>">
				<div class="form-group">
					<select name="langue" class="form-control">
						<option value="fr">Francais</option>
						<option value="en">Anglais</option>
						<option value="mal">Malgache</option>
					</select>
				</div>
				<button type="submit" class="btn btn-default">Changer</button>
			</form>
          </div><!-- /.tab-pane -->
          <!-- Stats tab content -->
          <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div><!-- /.tab-pane -->
        </div>
      </aside><!-- /.control-sidebar -->