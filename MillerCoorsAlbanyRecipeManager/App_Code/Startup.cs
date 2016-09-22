using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MillerCoorsAlbanyRecipeManager.Startup))]
namespace MillerCoorsAlbanyRecipeManager
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
