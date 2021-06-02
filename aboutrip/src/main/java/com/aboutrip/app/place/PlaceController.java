package com.aboutrip.app.place;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("place.placeController")
@RequestMapping("/place/*")
public class PlaceController {
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String placelist() throws Exception{
		return ".place.list";
	}
}
