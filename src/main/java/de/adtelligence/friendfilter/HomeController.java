/*
 * Copyright 2011 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package de.adtelligence.friendfilter;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.Page;
import org.springframework.social.facebook.api.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Simple little @Controller that invokes Facebook and renders the result.
 * The injected {@link Facebook} reference is configured with the required authorization credentials for the current user behind the scenes.
 * @author Keith Donald
 */
@Controller
public class HomeController {
	
  private final Facebook facebook;
  
  @Inject
  public HomeController(Facebook facebook) {
    this.facebook = facebook;
  }

  @RequestMapping(value = "/", method = RequestMethod.GET)
  public String home(Model model) {
    try {
      List<Page> interests = facebook.likeOperations().getInterests();
      model.addAttribute("username", facebook.userOperations().getUserProfile().getName());
      model.addAttribute("interests", interests);
    } catch (Exception ex) {
       return "error";
    }
    return "home";
  }
  
  @RequestMapping(value = "/friends_by_interest", method = RequestMethod.GET)
  public @ResponseBody List<String> friendsByInterest(@RequestParam("interest") String interest) {
    List<Reference> friends = facebook.friendOperations().getFriends();
    List<String> res = new ArrayList<String>();
    for (Reference friend: friends) {
      List<Page> friendInterests = facebook.likeOperations().getInterests(friend.getId());
      for (Page page : friendInterests) {
        if (page.getName().equals(interest)) {
          res.add(friend.getName());
          break;
        }
      }
    }
    return res;
  }

}
