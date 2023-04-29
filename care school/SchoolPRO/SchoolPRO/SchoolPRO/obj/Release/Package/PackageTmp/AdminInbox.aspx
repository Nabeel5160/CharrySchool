<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminInbox.aspx.cs" Inherits="SchoolPRO.AdminInbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <ul id="Ul3" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">

                <li class="active">
                    <%--<a data-toggle="tab" href="#inbox" data-target="inbox">
                                            <i class="blue icon-inbox bigger-130"></i>--%>
                    <%--<span class="bigger-110">Inbox</span>--%>
                    <asp:Button ID="btninbox" runat="server" Text="Inbox" Width="60" class="btn " OnClick="btninbox_Click" />
                    <%--</a>--%>
                </li>

                <li>
                    <%-- <a data-toggle="tab" href="#sent" data-target="sent">
                        <i class="orange icon-location-arrow bigger-130 "></i>
                    <span class="bigger-110">Sent</span>--%>
                    <asp:Button ID="btnsend" runat="server" Text="Sent" Width="55" class="btn" OnClick="btnsend_Click" />
                    <%--</a>--%>
                </li>

                <li>
                   <%-- <a data-toggle="tab" href="#draft" data-target="draft">
                        <i class="green icon-pencil bigger-130"></i>
                    <span class="bigger-110">Draft</span>--%>
                    <asp:Button ID="Button6" runat="server" Text="Draft" Width="55" class="btn" />
                    <%--</a>--%>
                </li>
                <li>
                    <asp:Label ID="labunrdmgs" runat="server"></asp:Label>
                </li>

                <%--<div class="space-6"></div>--%>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvtime" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View3" runat="server">
                                <div class="tabbable">

                                    <div class="table-responsive">
                                        <asp:GridView ID="GridView1" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nMsg_id" DataSourceID="InboxDS">

                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nMsg_id" HeaderText="nMsg_id" ReadOnly="True" InsertVisible="False" SortExpression="nMsg_id"></asp:BoundField>
                                                <asp:BoundField DataField="strMsgTitle" HeaderText="Message Tittle" SortExpression="strMsgTitle"></asp:BoundField>
                                                <asp:BoundField DataField="strMsgDesc" HeaderText="Message" SortExpression="strMsgDesc"></asp:BoundField>
                                                <asp:BoundField DataField="dtAddDate" HeaderText="Date" SortExpression="dtAddDate"></asp:BoundField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnmgssend0" runat="server" Text="Send Message" class="hidden-print width-100 pull-left btn btn-sm btn-success"/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource runat="server" ID="InboxDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nMsg_id, strMsgTitle, strMsgDesc, dtAddDate FROM tbl_Message WHERE (bisDeleted = @fbit) AND (bisRead = @fbit) AND (nsch_id=@schid) AND (nU_rcv_id=@secrec)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                <asp:SessionParameter Name="secrec" SessionField="uid" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <!-- /.tab-content -->
                                    </div>
                                    </ul>
                                </div>
                            </asp:View>

                            <asp:View ID="View2" runat="server">
                                <asp:GridView ID="GridView2" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nMsg_id" DataSourceID="SendDS">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nMsg_id" HeaderText="nMsg_id" ReadOnly="True" InsertVisible="False" SortExpression="nMsg_id"></asp:BoundField>
                                        <asp:BoundField DataField="Message Tittle" HeaderText="Message Tittle" SortExpression="Message Tittle"></asp:BoundField>
                                        <asp:BoundField DataField="Message" HeaderText="Message" SortExpression="Message"></asp:BoundField>
                                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnmgssend1" runat="server" Text="Send Message" class="hidden-print width-100 pull-left btn btn-sm btn-success"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="SendDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nMsg_id, strMsgTitle AS 'Message Tittle', strMsgDesc AS 'Message', dtAddDate AS 'Date' FROM tbl_Message WHERE (bisDeleted = @fbit) AND (nsch_id=@schid) AND (nU_sndr_id=@secrec)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="secrec" SessionField="uid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                        </asp:MultiView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ul>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script src="assets/js/jquery-2.0.3.min.js"></script>

    <!-- <![endif]-->

    <!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

    <!--[if !IE]> -->

    <script type="text/javascript">
        window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
    </script>

    <!-- <![endif]-->

    <!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

    <script type="text/javascript">
        if ("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
    </script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/typeahead-bs2.min.js"></script>

    <!-- page specific plugin scripts -->

    <script src="assets/js/bootstrap-tag.min.js"></script>
    <script src="assets/js/jquery.hotkeys.min.js"></script>
    <script src="assets/js/bootstrap-wysiwyg.min.js"></script>
    <script src="assets/js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="assets/js/jquery.ui.touch-punch.min.js"></script>
    <script src="assets/js/jquery.slimscroll.min.js"></script>

    <!-- ace scripts -->

    <script src="assets/js/ace-elements.min.js"></script>
    <script src="assets/js/ace.min.js"></script>

    <!-- inline scripts related to this page -->

    <script type="text/javascript">
        jQuery(function ($) {

            //handling tabs and loading/displaying relevant messages and forms
            //not needed if using the alternative view, as described in docs
            var prevTab = 'inbox'
            $('#inbox-tabs a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                var currentTab = $(e.target).data('target');
                if (currentTab == 'write') {
                    Inbox.show_form();
                }
                else {
                    if (prevTab == 'write')
                        Inbox.show_list();

                    //load and display the relevant messages 
                }
                prevTab = currentTab;
            })



            //basic initializations
            $('.message-list .message-item input[type=checkbox]').removeAttr('checked');
            $('.message-list').delegate('.message-item input[type=checkbox]', 'click', function () {
                $(this).closest('.message-item').toggleClass('selected');
                if (this.checked) Inbox.display_bar(1);//display action toolbar when a message is selected
                else {
                    Inbox.display_bar($('.message-list input[type=checkbox]:checked').length);
                    //determine number of selected messages and display/hide action toolbar accordingly
                }
            });


            //check/uncheck all messages
            $('#id-toggle-all').removeAttr('checked').on('click', function () {
                if (this.checked) {
                    Inbox.select_all();
                } else Inbox.select_none();
            });

            //select all
            $('#id-select-message-all').on('click', function (e) {
                e.preventDefault();
                Inbox.select_all();
            });

            //select none
            $('#id-select-message-none').on('click', function (e) {
                e.preventDefault();
                Inbox.select_none();
            });

            //select read
            $('#id-select-message-read').on('click', function (e) {
                e.preventDefault();
                Inbox.select_read();
            });

            //select unread
            $('#id-select-message-unread').on('click', function (e) {
                e.preventDefault();
                Inbox.select_unread();
            });

            /////////

            //display first message in a new area
            $('.message-list .message-item:eq(0) .text').on('click', function () {
                //show the loading icon
                $('.message-container').append('<div class="message-loading-overlay"><i class="icon-spin icon-spinner orange2 bigger-160"></i></div>');

                $('.message-inline-open').removeClass('message-inline-open').find('.message-content').remove();

                var message_list = $(this).closest('.message-list');

                //some waiting
                setTimeout(function () {

                    //hide everything that is after .message-list (which is either .message-content or .message-form)
                    message_list.next().addClass('hide');
                    $('.message-container').find('.message-loading-overlay').remove();

                    //close and remove the inline opened message if any!

                    //hide all navbars
                    $('.message-navbar').addClass('hide');
                    //now show the navbar for single message item
                    $('#id-message-item-navbar').removeClass('hide');

                    //hide all footers
                    $('.message-footer').addClass('hide');
                    //now show the alternative footer
                    $('.message-footer-style2').removeClass('hide');


                    //move .message-content next to .message-list and hide .message-list
                    message_list.addClass('hide').after($('.message-content')).next().removeClass('hide');

                    //add scrollbars to .message-body
                    $('.message-content .message-body').slimScroll({
                        height: 200,
                        railVisible: true
                    });

                }, 500 + parseInt(Math.random() * 500));
            });


            //display second message right inside the message list
            $('.message-list .message-item:eq(1) .text').on('click', function () {
                var message = $(this).closest('.message-item');

                //if message is open, then close it
                if (message.hasClass('message-inline-open')) {
                    message.removeClass('message-inline-open').find('.message-content').remove();
                    return;
                }

                $('.message-container').append('<div class="message-loading-overlay"><i class="icon-spin icon-spinner orange2 bigger-160"></i></div>');
                setTimeout(function () {
                    $('.message-container').find('.message-loading-overlay').remove();
                    message
                        .addClass('message-inline-open')
                        .append('<div class="message-content" />')
                    var content = message.find('.message-content:last').html($('#id-message-content').html());

                    content.find('.message-body').slimScroll({
                        height: 200,
                        railVisible: true
                    });

                }, 500 + parseInt(Math.random() * 500));

            });



            //back to message list
            $('.btn-back-message-list').on('click', function (e) {
                e.preventDefault();
                Inbox.show_list();
                $('#inbox-tabs a[data-target="inbox"]').tab('show');
            });



            //hide message list and display new message form
            /**
            $('.btn-new-mail').on('click', function(e){
                e.preventDefault();
                Inbox.show_form();
            });
            */




            var Inbox = {
                //displays a toolbar according to the number of selected messages
                display_bar: function (count) {
                    if (count == 0) {
                        $('#id-toggle-all').removeAttr('checked');
                        $('#id-message-list-navbar .message-toolbar').addClass('hide');
                        $('#id-message-list-navbar .message-infobar').removeClass('hide');
                    }
                    else {
                        $('#id-message-list-navbar .message-infobar').addClass('hide');
                        $('#id-message-list-navbar .message-toolbar').removeClass('hide');
                    }
                }
                ,
                select_all: function () {
                    var count = 0;
                    $('.message-item input[type=checkbox]').each(function () {
                        this.checked = true;
                        $(this).closest('.message-item').addClass('selected');
                        count++;
                    });

                    $('#id-toggle-all').get(0).checked = true;

                    Inbox.display_bar(count);
                }
                ,
                select_none: function () {
                    $('.message-item input[type=checkbox]').removeAttr('checked').closest('.message-item').removeClass('selected');
                    $('#id-toggle-all').get(0).checked = false;

                    Inbox.display_bar(0);
                }
                ,
                select_read: function () {
                    $('.message-unread input[type=checkbox]').removeAttr('checked').closest('.message-item').removeClass('selected');

                    var count = 0;
                    $('.message-item:not(.message-unread) input[type=checkbox]').each(function () {
                        this.checked = true;
                        $(this).closest('.message-item').addClass('selected');
                        count++;
                    });
                    Inbox.display_bar(count);
                }
                ,
                select_unread: function () {
                    $('.message-item:not(.message-unread) input[type=checkbox]').removeAttr('checked').closest('.message-item').removeClass('selected');

                    var count = 0;
                    $('.message-unread input[type=checkbox]').each(function () {
                        this.checked = true;
                        $(this).closest('.message-item').addClass('selected');
                        count++;
                    });

                    Inbox.display_bar(count);
                }
            }

            //show message list (back from writing mail or reading a message)
            Inbox.show_list = function () {
                $('.message-navbar').addClass('hide');
                $('#id-message-list-navbar').removeClass('hide');

                $('.message-footer').addClass('hide');
                $('.message-footer:not(.message-footer-style2)').removeClass('hide');

                $('.message-list').removeClass('hide').next().addClass('hide');
                //hide the message item / new message window and go back to list
            }

            //show write mail form
            Inbox.show_form = function () {
                if ($('.message-form').is(':visible')) return;
                if (!form_initialized) {
                    initialize_form();
                }


                var message = $('.message-list');
                $('.message-container').append('<div class="message-loading-overlay"><i class="icon-spin icon-spinner orange2 bigger-160"></i></div>');

                setTimeout(function () {
                    message.next().addClass('hide');

                    $('.message-container').find('.message-loading-overlay').remove();

                    $('.message-list').addClass('hide');
                    $('.message-footer').addClass('hide');
                    $('.message-form').removeClass('hide').insertAfter('.message-list');

                    $('.message-navbar').addClass('hide');
                    $('#id-message-new-navbar').removeClass('hide');


                    //reset form??
                    $('.message-form .wysiwyg-editor').empty();

                    $('.message-form .ace-file-input').closest('.file-input-container:not(:first-child)').remove();
                    $('.message-form input[type=file]').ace_file_input('reset_input');

                    $('.message-form').get(0).reset();

                }, 300 + parseInt(Math.random() * 300));
            }




            var form_initialized = false;
            function initialize_form() {
                if (form_initialized) return;
                form_initialized = true;

                //intialize wysiwyg editor
                $('.message-form .wysiwyg-editor').ace_wysiwyg({
                    toolbar:
                    [
                        'bold',
                        'italic',
                        'strikethrough',
                        'underline',
                        null,
                        'justifyleft',
                        'justifycenter',
                        'justifyright',
                        null,
                        'createLink',
                        'unlink',
                        null,
                        'undo',
                        'redo'
                    ]
                }).prev().addClass('wysiwyg-style1');

                //file input
                $('.message-form input[type=file]').ace_file_input()
                //and the wrap it inside .span7 for better display, perhaps
                .closest('.ace-file-input').addClass('width-90 inline').wrap('<div class="row file-input-container"><div class="col-sm-7"></div></div>');

                //the button to add a new file input
                $('#id-add-attachment').on('click', function () {
                    var file = $('<input type="file" name="attachment[]" />').appendTo('#form-attachments');
                    file.ace_file_input();
                    file.closest('.ace-file-input').addClass('width-90 inline').wrap('<div class="row file-input-container"><div class="col-sm-7"></div></div>')
                    .parent(/*.span7*/).append('<div class="action-buttons pull-right col-xs-1">\
							<a href="#" data-action="delete" class="middle">\
								<i class="icon-trash red bigger-130 middle"></i>\
							</a>\
						</div>').find('a[data-action=delete]').on('click', function (e) {
						    //the button that removes the newly inserted file input
						    e.preventDefault();
						    $(this).closest('.row').hide(300, function () {
						        $(this).remove();
						    });
						});
                });
            }//initialize_form


            //turn the recipient field into a tag input field!
            /**	
            var tag_input = $('#form-field-recipient');
            if(! ( /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase())) ) 
                tag_input.tag({placeholder:tag_input.attr('placeholder')});
        
        
            //and add form reset functionality
            $('.message-form button[type=reset]').on('click', function(){
                $('.message-form .message-body').empty();
                
                $('.message-form .ace-file-input:not(:first-child)').remove();
                $('.message-form input[type=file]').ace_file_input('reset_input');
                
                
                var val = tag_input.data('value');
                tag_input.parent().find('.tag').remove();
                $(val.split(',')).each(function(k,v){
                    tag_input.before('<span class="tag">'+v+'<button class="close" type="button">&times;</button></span>');
                });
            });
            */

        });
    </script>

</asp:Content>
