using com.SIXDegrees.ApplicationCore.BusinessLogic;
using com.SIXDegrees.ApplicationCore.BusinessLogic.Interfaces;
using com.SIXDegrees.Infrastructure.DataAccess;
using com.SIXDegrees.Infrastructure.DataAccess.Interfaces;
using com.SIXDegrees.Infrastructure.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace com.SIXDegrees.WebAPI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            #region DAL_Services           
            services.AddTransient<IUsuariosDAL, UsuariosDAL>();






            #endregion

            #region BL_Services
            services.AddTransient<IUsuarioBL, UsuarioBL>();






            #endregion

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
            services.AddCors(c =>
            {
                c.AddPolicy("OpenAll", opciones =>
                opciones.AllowAnyOrigin()
                        .AllowAnyMethod()
                        .AllowAnyHeader()
                        .WithHeaders("authorization", "accept", "content-type", "origin"));
            });
            services.AddSignalR();
            services.AddDbContext<SIXDegress_bdContext>(options => options.UseSqlServer(Configuration.GetConnectionString("TecnoCEDIEntities")));
            services.AddMvc(option => option.EnableEndpointRouting = false);
            services.AddMvc().AddJsonOptions(options => options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
            }


            app.Use(async (context, next) =>
            {
                context.Response.Headers.Add("X-Content-Type-Options", "nosniff");
                await next();
            });
           
            app.UseCors("OpenAll");
            //  app.UseHttpsRedirection();
            app.UseMvc();
        }

    }
}
