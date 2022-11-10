
 site = {
    name: 'Blog IRS',
    slogan: 'Talento, a gente já tem!'
  }
  
  $(document).ready(runApp);
  
  function runApp() {
  
    let path = localStorage.getItem('path');
    if (path) {
      localStorage.removeItem('path');  
      loadPage(path);
    } else {
      loadPage('home');
    }
  
    $(document).on('click', 'a', routerLink);
  }
  
  function routerLink() {
  
    let href = $(this).attr('href');
  
    if (
      href.substr(0, 7) == 'http://' ||
      href.substr(0, 8) == 'https://' ||
      href.substr(0, 1) == '#'
    ) return true;
  
    loadPage(href);
  
    return false;
  }
  
  function loadPage(route) {
  
    let page = {
      html: `pages/${route}/index.html`,
      css: `pages/${route}/style.css`,
      js: `pages/${route}/script.js`
    }
  
    $.get(page.html)
  
      .done(
  
        function (data) {
  
          $('#pageCSS').attr('href', page.css);
  
          $('main').html(data);
  
          $.getScript(page.js);
        }
      );
  
    window.scrollTo(0, 0);
  
    window.history.pushState({}, '', route);
  }
  
  function changeTitle(title = '') {
  
    if (title == '')
  
      tagTitle = `${site.name} ·:· ${site.slogan}`;
  
    else
  
      tagTitle = `${site.name} ·:· ${title}`;
  
    $('title').text(tagTitle);
  
  }