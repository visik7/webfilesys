package de.webfilesys.gui.blog;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.Element;
import org.w3c.dom.ProcessingInstruction;

import de.webfilesys.Comment;
import de.webfilesys.InvitationManager;
import de.webfilesys.LanguageManager;
import de.webfilesys.MetaInfManager;
import de.webfilesys.gui.xsl.XslRequestHandlerBase;
import de.webfilesys.util.UTF8URLEncoder;
import de.webfilesys.util.XmlUtil;

/**
 * @author Frank Hoehnel
 */
public class BlogListCommentsHandler extends XslRequestHandlerBase
{
	public BlogListCommentsHandler(
			HttpServletRequest req, 
    		HttpServletResponse resp,
            HttpSession session,
            PrintWriter output, 
            String uid)
	{
        super(req, resp, session, output, uid);
	}
	  
	protected void process()
	{
		String actPath = getParameter("filePath");

		if (!checkAccess(actPath))
		{
			return;
		}

		Element fileCommentsElement = doc.createElement("fileComments");
			
		doc.appendChild(fileCommentsElement);

		ProcessingInstruction xslRef = doc.createProcessingInstruction("xml-stylesheet", "type=\"text/xsl\" href=\"/doxee-internal/xsl/blog/comments.xsl\"");

		doc.insertBefore(xslRef, fileCommentsElement);

		XmlUtil.setChildText(fileCommentsElement, "css", userMgr.getCSS(uid), false);
		XmlUtil.setChildText(fileCommentsElement, "path", actPath, false);
	    XmlUtil.setChildText(fileCommentsElement, "language", language, false);
		
		XmlUtil.setChildText(fileCommentsElement, "encodedPath", UTF8URLEncoder.encode(actPath), false);
		XmlUtil.setChildText(fileCommentsElement, "pathForScript", insertDoubleBackslash(actPath), false);

		boolean modifyPermission=true;

		if (userMgr.getUserType(uid).equals("virtual"))
		{
			modifyPermission=InvitationManager.getInstance().commentsAllowed(uid);
		}
		
		if (modifyPermission)
		{
			XmlUtil.setChildText(fileCommentsElement, "modifyPermission", "true", false);
		}

		if (userMgr.getUserType(uid).equals("virtual"))
		{
			XmlUtil.setChildText(fileCommentsElement, "virtualUser", "true", false);
		}

		if (readonly)
		{
			XmlUtil.setChildText(fileCommentsElement, "readonly", "true", false);
		}
		
        String mobile = (String) session.getAttribute("mobile");

        if (mobile != null)
        {
            XmlUtil.setChildText(fileCommentsElement, "mobile", "true", false);
        }
            
		Element commentListElement = doc.createElement("comments");
		
		fileCommentsElement.appendChild(commentListElement);
		
		Vector listOfComments=MetaInfManager.getInstance().getListOfComments(actPath);

		if ((listOfComments != null) && (listOfComments.size() > 0))
		{
			SimpleDateFormat dateFormat = LanguageManager.getInstance().getDateFormat(language);

			for (int i = 0; i < listOfComments.size(); i++)
			{
				Comment comment=(Comment) listOfComments.elementAt(i);

				String login = comment.getUser();

				StringBuffer userString = new StringBuffer();
				
				if (!userMgr.userExists(login))
				{
					// anonymous guest who entered his name
					userString.append(login);
				}
				else if (userMgr.getUserType(login).equals("virtual"))
				{
					userString.append(getResource("label.guestuser","Guest"));
				}
				else
				{
					String firstName = userMgr.getFirstName(login);
					String lastName = userMgr.getLastName(login);

					if ((lastName != null) && (lastName.trim().length() > 0))
					{
						if (firstName != null)
						{
							userString.append(firstName);
							userString.append(" ");
						}

						userString.append(lastName);
					}
					else
					{
						userString.append(login);
					}
				}

				Element commentElement = doc.createElement("comment");
				
				commentListElement.appendChild(commentElement);
				
				XmlUtil.setChildText(commentElement, "user", userString.toString(), false);

				XmlUtil.setChildText(commentElement, "date", dateFormat.format(comment.getCreationDate()), false);

				XmlUtil.setChildText(commentElement, "msg", comment.getMessage(), true);
			}
		}
			
		this.processResponse("blog/comments.xsl", false);
    }
}