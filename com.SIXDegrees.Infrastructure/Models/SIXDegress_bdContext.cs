using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace com.SIXDegrees.Infrastructure.Models
{
    public partial class SIXDegress_bdContext : DbContext
    {
        public SIXDegress_bdContext()
        {
        }

        public SIXDegress_bdContext(DbContextOptions<SIXDegress_bdContext> options)
            : base(options)
        {
        }

        public virtual DbSet<usuario> usuario { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=DESKTOP-IQ4QA8J;Database=pruebaSD;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.6-servicing-10079");

            modelBuilder.Entity<usuario>(entity =>
            {
                entity.Property(e => e.usuarioApellido)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.usuarioNombre)
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });
        }
    }
}
